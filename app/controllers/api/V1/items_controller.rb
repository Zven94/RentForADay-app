class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all.map do |item|
      {
        id: item.id,
        name: item.name,
        city: item.city,
        description: item.description,
        price: item.price,
        # image: "#{request.base_url}/assets/#{item.image}"
        image: item.image.attached? ? rails_blob_path(item.image, only_path: true) : nil
      }
    end
    render json: items
  end

  def new
    Item.new
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: item
    else
      render json: { errors: item.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    render json: item
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :city, :image)
  end
end
