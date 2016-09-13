class Metric < ApplicationRecord

  # Associations
  belongs_to :client
  has_many :form_conversions, class_name: "Metric::Form::Conversion"
  has_many :campaign_conversions, class_name: "Metric::Campaign::Conversion"

end
