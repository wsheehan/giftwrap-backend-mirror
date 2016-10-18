class Metric::FormConversion < ApplicationRecord

  # Associations
  belongs_to :client
  belongs_to :metric
  belongs_to :gift
  belongs_to :donor
  belongs_to :campaign_conversion, class_name: "Metric::CampaignConversion"

end