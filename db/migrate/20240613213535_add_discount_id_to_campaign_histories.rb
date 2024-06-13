class AddDiscountIdToCampaignHistories < ActiveRecord::Migration[7.0]
  def change
    add_reference :campaign_histories, :discount, foreign_key: true
  end
end
