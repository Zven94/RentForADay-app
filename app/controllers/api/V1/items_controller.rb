class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all.map do |item|
      {
        id: item.id,
        name: item.name,
        city: item.city,
        description: item.description,
        price: item.price,
        image: item.image
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

    if item.destroy
      render json: item
    else
      render json: { errors: item.errors }, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :city, :image)
  end
end
