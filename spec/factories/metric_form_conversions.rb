FactoryGirl.define do
  factory :metric_form_conversion, class: 'Metric::FormConversion' do
    metric
    gift
    donor
  end
end
