class Api::V1::AppointmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def index
    @appointments = Appointment.where(user_id: params[:user_id])

    render json: @appointments, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'No reserves yet' }, status: :not_found
  end

  private

  def reserve_params
    params.require(:reserve).permit(:user_id, :item_id, :date, :city, :id)
  end
end
