# == Schema Information
#
# Table name: campaign_emails
#
#  id           :integer          not null, primary key
#  campaign_id  :integer
#  subject      :string
#  body         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  header_image :string
#

FactoryGirl.define do
  factory :campaign_email do
    campaign nil
    title "MyString"
    body "MyString"
  end
end
