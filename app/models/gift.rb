# == Schema Information
#
# Table name: gifts
#
#  id          :integer          not null, primary key
#  total       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  donor_id    :integer
#  campaign_id :integer
#  designation :string
#  gift_type   :string
#  client_id   :integer
#

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
