class Gift < ActiveRecord::Base

	# Associations
  belongs_to :school
  belongs_to :donor

  has_one :campaign_conversion, class_name: "Metric::CampaignConversion"
  has_one :form_conversion, class_name: "Metric::FormConversion"

  # Validations
	validates :total, presence: true
	validates :donor_id, presence: true

end
