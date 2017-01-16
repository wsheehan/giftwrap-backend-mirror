# == Schema Information
#
# Table name: donor_lists
#
#  id          :integer          not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :integer
#  description :string
#

FactoryGirl.define do
  factory :donor_list do
    title Faker::Company.buzzword
  end
end
