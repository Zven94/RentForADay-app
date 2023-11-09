require 'swagger_helper'

RSpec.describe 'Items API', type: :request do
  path '/api/v1/items' do
    get 'Get a list of all items' do
      tags 'Items'
      produces 'application/json'

      response '200', 'Items found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   city: { type: :string },
                   description: { type: :string },
                   image: { type: :string }
                 },
                 required: %w[id name city description image],
                 message: { type: :string }
               }
        run_test!
      end

      response '200', 'No items Found' do
        run_test!
      end
    end
  end

  path '/api/v1/items' do
    post 'Creates an Item' do
      tags 'items'
      consumes 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          price: { type: :string },
          image: { type: :string },
          city: { type: :string }
        },
        required: %w[name description price city image]
      }

      response '200', 'item Created' do
        let(:item) do
          Item.create(name: 'item name', description: 'item Description', price: '2500.78', city: 'Pucon',
                      image: 'photo.png')
        end

        run_test!
      end

      response '422', 'Invalid Request' do
        let(:item) do
          {
            name: '',
            description: 'item Description',
            price: 'Invalid',
            city: ''
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/items/{id}' do
    delete 'Delete an item' do
      tags 'items'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'Item deleted successfully' do
        let!(:item) { Item.create(name: 'item name', description: 'item Description', price: '2500.78', city: 'Pucon', image: 'photo.png') }
        let(:id) { item.id }

        run_test!

        it 'deletes the item from the database' do
          expect { item.reload }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
  end
end
