FactoryGirl.define do
  factory :client_policy, class: 'Client::Policy' do
    app_id "MyString"
    app_public_key "MyString"
    app_secret_key "MyString"
  end
end
