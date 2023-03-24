class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9]+\z/ }
end
