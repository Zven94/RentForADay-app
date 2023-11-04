require 'rails_helper'

RSpec.describe 'CurrentUsers', type: :request do
  after(:all) do
    User.destroy_all
  end

  describe 'GET /current_user - to get the current user' do
    user = User.create(
      name: 'Test User',
      email: 'testmail@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    )
    user.save

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
        get '/current_user'
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['email']).to eq(user.email)
        expect(JSON.parse(response.body)['name']).to eq(user.name)
        expect(JSON.parse(response.body)['id']).to be_a(Integer)
        expect(JSON.parse(response.body)['created_at']).not_to eq(nil)
        expect(JSON.parse(response.body)['updated_at']).not_to eq(nil)
        expect(JSON.parse(response.body)['jti']).not_to eq(nil)
        expect(JSON.parse(response.body)['jti'].length).to eq(36)
      end
    end

    context 'when the request is invalid' do
      before { post '/login', params: invalid_attributes }
      it 'returns a 401 - unauthorized' do
        get '/current_user'
        expect(response).to have_http_status(401)
      end
    end

    context 'when the request is invalid' do
      it 'returns a 401 - unauthorized' do
        get '/current_user'
        expect(response).to have_http_status(401)
      end
    end

    context 'when the request is invalid' do
      it 'returns a 401 - unauthorized' do
        delete '/logout'
        get '/current_user'
        expect(response).to have_http_status(401)
      end
    end
  end
end
