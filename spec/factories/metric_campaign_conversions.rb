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

FactoryGirl.define do
  factory :metric_campaign_conversion, class: 'Metric::CampaignConversion' do
    campaign
    donor
    metric
    gift_method "Text"
  end
end
