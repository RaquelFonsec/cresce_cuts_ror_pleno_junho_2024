class AddDiscountIdToCampaign < ActiveRecord::Migration[7.0]
  def change
    add_reference :campaigns, :discount, foreign_key: true
  end
end
