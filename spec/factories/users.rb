FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password "foobar"

    sequence :email do |n|
      "person#{n}@school.edu"
    end

    client
  end
end
