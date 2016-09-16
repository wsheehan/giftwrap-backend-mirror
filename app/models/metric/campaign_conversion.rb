class Metric::CampaignConversion < ApplicationRecord

  # Associations
  belongs_to :campaign
  belongs_to :donor
  belongs_to :metric
  belongs_to :gift

  has_one :form_conversion, class_name: "Metric::FormConversion"

end