class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  valides :name, :city, :date, presence: true
end
