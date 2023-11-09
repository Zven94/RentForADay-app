class Api::V1::AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.includes(:item).where(user_id: params[:user_id])

    render json: @appointments.to_json(include: :item), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'No reserves yet' }, status: 404
  end

  def create
    Item.find(params[:item_id])
    json_request = JSON.parse(request.body.read)
    json_request['city']
    json_request['date']

    @appointment = Appointment.new(user_id: params[:user_id], item_id: params[:item_id],
                                   date: params[:date], city: params[:city])

    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: { error: @appointment.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @appointments = Appointment.find(params[:id])
    @appointments.destroy

    render json: { message: 'Appointment deleted' }, status: 201
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Appointment not found' }, status: :not_found
  end

  private

  def reserve_params
    params.require(:reserve).permit(:user_id, :item_id, :date, :city, :id)
  end
end
