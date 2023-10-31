class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, :recoverable, :rememberable, :validatable
  has_many :appointments

  validates :name, presence: true, length: { maximum: 50 }
end
