class Client < ApplicationRecord
  has_many :policies, class_name: 'Client::Policy'
  has_many :users
  has_many :donors
  has_one :form
end
