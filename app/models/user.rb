class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

         has_many :attendees
         has_many :events, through: :attendees, dependent: :destroy

  validates :name, presence: true, length: {maximum: 25}, on: :create, allow_nil: false
end
