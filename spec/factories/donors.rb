FactoryGirl.define do
  factory :donor do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    key SecureRandom.urlsafe_base64(16)

    client
    campaign
  end
end
