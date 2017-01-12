FactoryGirl.define do
  factory :donor do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    key SecureRandom.urlsafe_base64(16)

    sequence :email do |n|
      "person#{n}@company.com"
    end

    client
    campaign

    # factory :donor_with_payment_info do
    #   braintree_customer_id "12345"
    # end
  end
end
