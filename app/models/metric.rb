class Metric < ApplicationRecord

  # Associations
  belongs_to :client
  has_one :form_conversion, class_name: "Metric::Form::Conversion"
  has_many :campaign_conversions, class_name: "Metric::Campaign::Conversion"

end
