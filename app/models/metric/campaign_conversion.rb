# == Schema Information
#
# Table name: metric_campaign_conversions
#
#  id           :integer          not null, primary key
#  campaign_id  :integer
#  donor_id     :integer
#  metric_id    :integer
#  gift_method  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  gift_id      :integer
#  subscription :boolean          default(FALSE)
#

class Metric::CampaignConversion < ApplicationRecord

  # Associations
  belongs_to :campaign
  belongs_to :donor
  belongs_to :metric
  belongs_to :gift

  has_one :form_conversion, class_name: "Metric::FormConversion"

end
