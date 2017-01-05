FactoryGirl.define do
  factory :client do
    name Faker::Company.name
    metric

    factory :client_with_form do
      form
    end

    factory :client_with_donors do
      transient do
        donors_count 5
      end
      after(:create) do |client, evaluator|
        create_list(:donor, evaluator.donors_count, client: client)
      end

      factory :client_with_campaigns do
        transient do
          campaigns_count 5
        end
        after(:create) do |client, evaluator|
          create_list(:campaign, evaluator.campaigns_count, client: client)
        end
      end
    end
  end
end
