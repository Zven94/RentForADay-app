class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :city, :date, presence: true
  validates_uniqueness_of :item_id, scope: :date, message: 'Appointment is not available, please choose another day'
end
