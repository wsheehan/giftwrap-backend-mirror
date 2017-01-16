# == Schema Information
#
# Table name: donors
#
#  id                    :integer          not null, primary key
#  first_name            :string
#  last_name             :string
#  email                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  key                   :string
#  braintree_customer_id :string
#  phone_number          :string
#  gift_frequency        :string
#  subscription_id       :integer
#  subscription_start    :date
#  subscription_total    :string
#  client_id             :integer
#  affiliation           :string
#  class_year            :integer
#  campaign_id           :integer
#

FactoryGirl.define do
  factory :donor do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    key SecureRandom.urlsafe_base64(16)

    sequence :email do |n|
      "person#{n}@company.com"
    end
  end
end
