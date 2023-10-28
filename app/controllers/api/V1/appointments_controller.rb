class Api::V1::AppointmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def index
    @appointments = Appointment.where(user_id: params[:user_id])

    render json: @appointments, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'No reserves yet' }, status: :not_found
  end

  def create
    item = Item.find(params[:item_id])
    json_request = JSON.parse(request.body.read)
    city = json_request['city']
    date = json_request['date']

    @appointments = Appointment.create(user_id: params[:user_id], item_id: params[:item_id], date: date, city: city)

    render json: @appointments, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'No reserves yet' }, status: :not_found
  end

  private

  def reserve_params
    params.require(:reserve).permit(:user_id, :item_id, :date, :city, :id)
  end
end
