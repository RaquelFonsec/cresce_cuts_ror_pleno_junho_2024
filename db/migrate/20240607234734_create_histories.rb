class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_histories do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.datetime :data_hora

      t.timestamps
    end
  end
end
