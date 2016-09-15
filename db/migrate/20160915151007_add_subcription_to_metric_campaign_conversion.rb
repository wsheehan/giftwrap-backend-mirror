class AddSubcriptionToMetricCampaignConversion < ActiveRecord::Migration[5.0]
  def change
    add_column :metric_campaign_conversions, :subscription, :boolean, default: false
  end
end
