require 'rails_helper'

RSpec.describe 'Api::V1::Registrations', type: :request do
  describe 'POST /api/v1/users - to create a new user' do
    let(:valid_attributes) do
      {
        user: {
          email: 'Erika@test.com',
          password: 'password',
          name: 'Erika Nohelí'
        }
      }
    end

    let(:invalid_attributes) do
      {
        user: {
          password: 'password',
          name: 'Erika Nohelí'
        }
      }
    end

    context 'when the request is valid' do
      before { post '/api/v1/users', params: valid_attributes }
      it 'creates a new user' do
        expect(response).to have_http_status(200)
      end
      it 'returns a success message' do
        expect(JSON.parse(response.body)['success']).to eq(true)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/users', params: invalid_attributes }
      it 'returns a failure message' do
        expect(JSON.parse(response.body)['message']).to eq(["Email can't be blank"])
      end
    end
  end
end
