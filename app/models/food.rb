class Food < ApplicationRecord
    belongs_to :user
    validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9]+\z/ }
end
