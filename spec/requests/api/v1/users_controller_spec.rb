require 'rails_helper'

RSpec.describe 'Api::Users', type: :request do
  before(:all) do
    @user = User.create(
      name: 'Test User',
      email: 'test@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  after(:all) do
    @user.destroy
  end

  describe 'GET /api/v1/users' do
    it 'should return success response' do
      get '/api/v1/users'
      expect(response).to have_http_status(200)
    end

    it 'should return all users' do
      get '/api/v1/users'
      expect(JSON.parse(response.body)['users'].size).to eq(1)
    end
  end

  describe 'POST /api/v1/users' do
    it 'should return success response' do
      post '/api/v1/users', params: {
        user: {
          name: 'Test User 2',
          email: 'test@gmail.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }
      expect(response).to have_http_status(200)
    end

    it 'should create a new user' do
      expect do
        post '/api/v1/users', params: {
          user: {
            name: 'Test User 2',
            email: 'testing@gmail.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end.to change { User.count }.from(1).to(2)
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    it 'should return success response' do
      delete "/api/v1/users/#{User.last.id}"
      expect(response).to have_http_status(200)
    end

    it 'should delete a user' do
      expect do
        delete "/api/v1/users/#{User.last.id}"
      end.to change { User.count }.from(1).to(0)
    end
  end
end
