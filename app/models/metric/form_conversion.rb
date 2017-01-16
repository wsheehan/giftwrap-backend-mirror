# == Schema Information
#
# Table name: metric_form_conversions
#
#  id                             :integer          not null, primary key
#  hit_time                       :datetime
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  metric_id                      :integer
#  metric_campaign_conversions_id :integer
#  gift_id                        :integer
#  donor_id                       :integer
#

class Metric::FormConversion < ApplicationRecord

  # Associations
  belongs_to :client
  belongs_to :metric
  belongs_to :gift
  belongs_to :donor
  belongs_to :campaign_conversion, class_name: "Metric::CampaignConversion"

end
