class AddGiftReferenceToMetricCampaignConversion < ActiveRecord::Migration[5.0]
  def change
    add_reference :metric_campaign_conversions, :gift, foreign_key: true
    remove_column :metric_campaign_conversions, :converted
  end
end
