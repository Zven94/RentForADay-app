class User < ApplicationRecord
  has_many :appointments

  validates :name, presence: true, length: { maximum: 50 }
end
