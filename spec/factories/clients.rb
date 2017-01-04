FactoryGirl.define do
  factory :client do
    name Faker::Company.name
    form
    metric

    factory :client_with_donors do
      transient do
        donors_count 5
      end
      after(:create) do |client, evaluator|
        create_list(:donor, evaluator.donors_count, client: client)
      end
    end
  end
end
