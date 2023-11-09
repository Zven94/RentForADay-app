require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      @item = Item.create(name: 'Hause 1', price: 100, city: 'Buenos Aires', description: 'Hause 1', image: 'image')
    end

    it 'returns http success: 200 code' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'JSON body response contains expected item attributes' do
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response.first.keys).to match_array(%w[id name price city description image])
    end

    it 'Show all items' do
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response.count).to eq(1)
    end

    it 'Delete item' do
      expect { delete :destroy, params: { id: @item.id } }.to change(Item, :count).by(-1)
    end
  end
end
