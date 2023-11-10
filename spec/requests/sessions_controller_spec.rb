require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  describe 'POST /login - to log in a user' do
    user = User.create(
      name: 'Test User',
      email: 'test@gmail.com',
      password: 'password123',
      password_confirmation: 'password123'
    )

    let(:valid_attributes) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    let(:invalid_attributes) do
      {
        user: {
          email: '',
          password: ''
        }
      }
    end

    context 'when the request is invalid' do
      before { post '/login', params: invalid_attributes }
      it 'returns a 401 - unauthorized' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
