class CreateMetricCampaignConversions < ActiveRecord::Migration[5.0]
  def change
    create_table :metric_campaign_conversions do |t|
      t.references :campaign, foreign_key: true
      t.references :donor, foreign_key: true
      t.references :metric, foreign_key: true
      t.boolean :converted
      t.string :gift_method

      t.timestamps
    end
  end
end
