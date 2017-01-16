class Gift < ActiveRecord::Base

	# Associations
  belongs_to :client
  belongs_to :donor
  belongs_to :campaign

  has_one :campaign_conversion, class_name: "Metric::CampaignConversion"
  has_one :form_conversion, class_name: "Metric::FormConversion"

  # Validations
	validates :total, presence: true
	validates :donor_id, presence: true

end
