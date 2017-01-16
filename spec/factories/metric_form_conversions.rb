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

FactoryGirl.define do
  factory :metric_form_conversion, class: 'Metric::FormConversion' do
    metric
    gift
    donor
  end
end
