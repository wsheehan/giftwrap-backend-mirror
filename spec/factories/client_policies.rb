# == Schema Information
#
# Table name: client_policies
#
#  id             :integer          not null, primary key
#  app_id         :string           not null
#  app_public_key :string
#  app_secret_key :string
#  client_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :client_policy, class: 'Client::Policy' do
    app_id "MyString"
    app_public_key "MyString"
    app_secret_key "MyString"
  end
end
