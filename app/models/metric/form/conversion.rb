class Metric::Form::Conversion < ApplicationRecord

  # Associations
  belongs_to :metric
  belongs_to :campaign_conversion, class_name: "Metric::Campaign::Conversion"

end