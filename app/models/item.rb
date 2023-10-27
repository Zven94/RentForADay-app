class Item < ApplicationRecord
  has_many :appointments

  validates :name, :city, :date, :description, presence: true
  validates :name, length: { maximum: 50 }
  valides :price, presence: true, numericality: { greater_than: 0 }
end
