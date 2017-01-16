# == Schema Information
#
# Table name: campaigns
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  client_id     :integer
#  donor_list_id :integer
#

FactoryGirl.define do
  factory :campaign do
    client
  end
end
