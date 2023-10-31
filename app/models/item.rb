class Item < ApplicationRecord
  has_many :appointments

  validates :name, :city, :description, presence: true
  validates :name, length: { maximum: 50 }
  validates :price, presence: true, numericality: { greater_than: 0 }
end
