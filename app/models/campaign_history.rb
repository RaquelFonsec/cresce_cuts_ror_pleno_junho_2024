class CampaignHistory < ApplicationRecord
  belongs_to :campaign
  belongs_to :user
  belongs_to :discount

  attr_accessor :change_description
end
