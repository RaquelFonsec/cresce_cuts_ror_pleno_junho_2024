class Product < ApplicationRecord
  has_many :campaigns
  validates :name, :price, presence: true
end
