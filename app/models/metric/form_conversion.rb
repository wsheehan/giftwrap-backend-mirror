class Metric::FormConversion < ApplicationRecord

  # Associations
  belongs_to :metric
  belongs_to :campaign_conversion, class_name: "Metric::CampaignConversion"

end