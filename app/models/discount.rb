class Discount < ApplicationRecord
  belongs_to :campaign
  belongs_to :user

  validates :discount_type, presence: true
  validates :discount_value, presence: true

  after_save :record_history

  def discount_price
    if discount_type == 'percentual'
      campaign.product.price - (campaign.product.price * discount_value / 100)
    elsif discount_type == 'valor_fixo'
      campaign.product.price - discount_value
    else
      campaign.product.price
    end
  end

  private

  def record_history
    CampaignHistory.create!(
      discount: self,
      user: self.user,
      campaign: self.campaign,
      change_description: "Discount created or updated"
    )
  end
end
