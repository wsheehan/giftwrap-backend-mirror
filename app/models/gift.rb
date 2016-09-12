class Gift < ActiveRecord::Base

	# Associations
  belongs_to :school
  belongs_to :donor
  has_one :campaign_conversion, class_name: "Metric::Campaign::Conversion"

  # Validations
	validates :total, presence: true
	validates :donor_id, presence: true

end
