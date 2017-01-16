# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :integer
#  password_digest :string
#

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
