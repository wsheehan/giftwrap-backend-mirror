# == Schema Information
#
# Table name: schools
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  designation :string           is an Array
#

FactoryGirl.define do
  factory :school do
    name "MyString"
  end

end
