# == Schema Information
#
# Table name: campaigns
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  client_id     :integer
#  donor_list_id :integer
#

class Campaign < ApplicationRecord

  # Associations
  belongs_to :user
  belongs_to :client
  belongs_to :donor_list
  has_many :campaign_conversions, class_name: "Metric::CampaignConversion"

  has_one :text, class_name: 'Campaign::Text'
  has_one :email, class_name: 'Campaign::Email'

  def donor_list_donors
    donor_list.donors
  end

end
