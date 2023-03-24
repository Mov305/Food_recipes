class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :foods
  has_many :recipes

  validates :name, presence: true, length: { maximum: 50 }

  def admin?
    role == 'admin'
  end
end
