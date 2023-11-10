require 'swagger_helper'

describe 'Users API' do
  path '/api/v1/users' do
    get 'Get a list of all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'Users found' do
        schema type: :object, properties: {
          success: { type: :boolean },
          users: {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                email: { type: :string },
                name: { type: :string },
                created_at: { type: :string },
                updated_at: { type: :string }
              },
              required: %w[id name email]
            }
          }
        }
        let(:user) { User.create(name: 'Test name', email: 'test4@example.com', password: '12345678') }
        run_test!
      end
    end
  end
  path '/api/v1/users' do
    post 'Creates User' do
      tags 'User'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object, properties: {
                         user: {
                           type: :object,
                           properties: {
                             name: { type: :string },
                             email: { type: :string },
                             password: { type: :string }
                           }
                         }
                       },
        required: %w[email password]
      }

      response '200', 'User Created' do
        let(:user) { User.create(name: 'Test name', email: 'test4@example.com', password: '12345678') }

        run_test!
      end
    end
  end
  path '/login' do
    post 'Login User' do
      tags 'User'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object, properties: {
                         user: {
                           type: :object,
                           properties: {
                             email: { type: :string },
                             password: { type: :string }
                           }
                         }
                       },
        required: %w[email password]
      }

      response '401', 'Invalid credentials' do
        let(:user) { User.create(name: 'Test name', email: 'test4@example.com', password: '12345678') }
        let(:invalid_params) { { user: { email: user.email, password: 'invalid_password' } } }

        run_test!
      end
    end
  end
end
