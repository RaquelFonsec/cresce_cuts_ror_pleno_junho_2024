class Discount < ApplicationRecord
  belongs_to :campaign
  belongs_to :user

  after_save :record_history

  def record_history
    self.campaign.campaign_histories.create(
      user: self.user,
      status: self.campaign.status,
      data_hora: Time.current,
      change_description: "Discount updated to #{self.discount_value} #{self.discount_type}"
    )
  end

  
  
    def discount_price
      if discount_type == 'percentual'
        campaign.product.price - (campaign.product.price * discount_value / 100)
      elsif discount_type == 'valor_fixo'
        campaign.product.price - discount_value
      else
        campaign.product.price
      end
    end
  end
  
