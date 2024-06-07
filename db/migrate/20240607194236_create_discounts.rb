class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.string :discount_type
      t.float :discount_value
      t.integer :status
      t.integer :applied_by
      t.datetime :applied_at
      t.references :campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
