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

  path '/api/v1/users/{user_id}/appointments' do
    parameter name: :user_id, in: :path, type: :integer, description: 'user_id', required: true

    post 'Add an appointment' do
      tags 'Appointment'
      consumes 'application/json', 'application/xml'
      parameter name: :appointment, in: :body, description: 'New Apponitment',

                schema: {
                  type: :object,
                  properties: {
                    item_id: { type: :integer },
                    city: { type: :string },
                    date: { type: :date }
                  }
                }
      response '201', 'blog created' do
        let(:user_id) { User.create(name: 'Test name', email: 'test4@example.com', password: '123456').id }
        let(:item_id) { Item.create(name: 'Item2', city: 'City', price: '100', description: 'Test description').id }
        let(:appointment) { { item_id:, city: 'Test city', date: '02/10/2023' } }

        run_test!
      end

      response '422', 'unprocessable_entity' do
        let(:user_id) { User.create(name: 'Test name', email: 'test4@example.com', password: '123456').id }
        let(:item_id) { Item.create(name: 'Item2', city: 'City', price: '100', description: 'Test description').id }
        let(:appointment) { { item_id:, city: '', date: '02/10/2023' } }

        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/appointments/{id}' do
    parameter name: :user_id, in: :path, type: :string, description: 'User id'
    parameter name: :id, in: :path, type: :string, description: 'Appointment id'

    delete('Delete appointment') do
      tags 'Delete appointment'
      consumes 'application/json', 'application/xml'

      response '201', 'Appointment delete' do
        let(:user_id) { User.create(name: 'Test name', email: 'test4@example.com', password: '123456').id }
        let(:item_id) { Item.create(name: 'Item', city: 'Test city', price: '100', description: 'Test description').id }
        let(:id) { Appointment.create(item_id:, city: 'Test city', date: '02/10/2023', user_id:).id }

        run_test!
      end
    end
  end
end
