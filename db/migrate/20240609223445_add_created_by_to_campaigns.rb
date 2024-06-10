class AddCreatedByToCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :created_by, :string
  end
end
