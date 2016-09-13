class Gift < ActiveRecord::Base

	# Associations
  belongs_to :school
  belongs_to :donor

  has_one :campaign_conversion, class_name: "Metric::Campaign::Conversion"
  has_one :form_conversion, class_name: "Metric::Form::Conversion"

  # Validations
	validates :total, presence: true
	validates :donor_id, presence: true

end
