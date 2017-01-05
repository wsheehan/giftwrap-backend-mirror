FactoryGirl.define do
  factory :metric_campaign_conversion, class: 'Metric::CampaignConversion' do
    campaign
    donor
    metric
    gift_method "Text"
  end
end
