# == Schema Information
#
# Table name: campaign_texts
#
#  id          :integer          not null, primary key
#  campaign_id :integer
#  body        :string
#  from        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :campaign_text do
    campaign nil
    body "MyString"
    from "MyString"
  end
end
