require 'swagger_helper'

RSpec.describe 'Appointment API', type: :request do
  path '/api/v1/users/{user_id}/appointments' do
    parameter name: 'user_id', in: :path, type: :integer, description: 'user_id', required: true

    get('list appointments by user') do
      tags 'Comments by posts'
      produces 'application/json', 'application/xml'

      response '200', 'Comments found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   item_id: { type: :integer },
                   city: { type: :string },
                   date: { type: :string }
                 },
                 required: %w[id user_id item_id city date]
               }

        let(:user_id) { User.create(name: 'Test name', email: 'test4@example.com', password: '123456').id }
        let(:item_id) { Item.create(name: 'Item2', city: 'City', price: '100', description: 'Test description').id }

        run_test!
      end
    end
  end
end
