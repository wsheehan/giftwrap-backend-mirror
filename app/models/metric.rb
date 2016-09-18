class Metric < ApplicationRecord

  # Associations
  belongs_to :client
  has_many :form_conversions, class_name: "Metric::FormConversion"
  has_many :campaign_conversions, class_name: "Metric::CampaignConversion"

end
