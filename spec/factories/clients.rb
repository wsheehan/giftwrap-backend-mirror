# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :client do
    name Faker::Company.name
    metric

    transient do
      donors_count 1
    end

    factory :client_with_users_and_donors do
      transient do
        users_count 1
      end
      after(:create) do |client, evaluator|
        create_list(:donor, evaluator.donors_count, client: client)
        create_list(:user, evaluator.users_count, client: client)
      end
    end

    factory :client_with_form do
      form
    end

    factory :client_with_donors do
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

    factory :client_with_payment_info_donors do
      after(:create) do |client, evaluator|
        create_list(:donor_with_payment_info, evaluator.donors_count, client: client)
      end
    end
  end
end
