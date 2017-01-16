# == Schema Information
#
# Table name: metrics
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :metric do
  end
end
