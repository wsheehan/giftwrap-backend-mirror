class CreateMetricCampaignHellos < ActiveRecord::Migration[5.0]
  def change
    create_table :metric_campaign_hellos do |t|

      t.timestamps
    end
  end
end
