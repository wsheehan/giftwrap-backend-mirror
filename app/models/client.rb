class Client < ApplicationRecord

  # Associations
  has_many :users
  has_many :donors
  has_many :donor_lists
  has_many :gifts
  has_many :campaigns
  has_many :subscriptions
  has_many :metrics
  has_many :policies, class_name: 'Client::Policy'
  has_one :form
  has_one :school

end
