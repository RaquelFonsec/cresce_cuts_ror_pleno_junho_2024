class CampaignHistory < ApplicationRecord
  belongs_to :campaign
  belongs_to :user
  attr_accessor :change_description
end
