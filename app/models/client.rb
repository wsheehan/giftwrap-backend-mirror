class Client < ApplicationRecord
  has_many :policies, class_name: 'Client::Policy'
  has_many :donors
end
