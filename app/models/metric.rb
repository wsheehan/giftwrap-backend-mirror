class Metric < ApplicationRecord

  # Associations
  belongs_to :client
  has_one :form_conversion, class_name: "Metric::Form::Conversion"

end
