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
