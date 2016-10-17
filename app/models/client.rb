class Client < ApplicationRecord

  # Associations
  has_many :users
  has_many :donors
  has_many :donor_lists
  has_many :gifts
  has_many :campaigns
  has_many :subscriptions
  has_one :metric
  has_many :policies, class_name: 'Client::Policy'
  has_many :form_conversions, class_name: 'Metric:FormConversion'
  has_one :form
  has_one :school

end
