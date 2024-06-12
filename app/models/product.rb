class Product < ApplicationRecord
  has_many :campaigns
  has_one_attached :image
end
