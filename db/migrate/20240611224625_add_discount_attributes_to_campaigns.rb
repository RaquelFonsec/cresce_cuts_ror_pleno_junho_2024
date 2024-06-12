class AddDiscountAttributesToCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :discount_attributes, :json
  end
end
