# == Schema Information
#
# Table name: metrics
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Metric < ApplicationRecord

  # Associations
  belongs_to :client
  has_many :form_conversions, class_name: "Metric::FormConversion"
  has_many :campaign_conversions, class_name: "Metric::CampaignConversion"

end
