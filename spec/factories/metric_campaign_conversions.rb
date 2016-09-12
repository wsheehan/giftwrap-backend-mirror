FactoryGirl.define do
  factory :metric_campaign_conversion, class: 'Metric::Campaign::Conversion' do
    campaign nil
    donor nil
    metric nil
    converted false
    gift_method "MyString"
  end
end
