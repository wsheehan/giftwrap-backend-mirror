class Client < ApplicationRecord
  has_many :urls, class_name: 'Client::Url'
  has_many :policies, class_name: 'Client::Policy'
end
