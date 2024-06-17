class CampaignHistory < ApplicationRecord
  belongs_to :campaign
  belongs_to :user
  belongs_to :discount
  attr_accessor :user_email
  attr_accessor :changes_description
end
