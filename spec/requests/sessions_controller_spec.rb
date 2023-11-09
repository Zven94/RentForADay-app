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

    context 'when the request is valid' do
      before { post '/login', params: valid_attributes }
      it 'returns a 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns a success message' do
        expect(JSON.parse(response.body)['status']['message']).to eq('Logged in sucessfully.')
      end

      it 'returns a token' do
        # returns a bearer token
        expect(response.headers['authorization']).not_to eq(nil)
        # returns a cookie
        expect(response.cookies['_rent_for_a_day_app_session']).not_to eq(nil)
      end
    end

    context 'when the request is invalid' do
      before { post '/login', params: invalid_attributes }
      it 'returns a 401 - unauthorized' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
