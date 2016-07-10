class School < ApplicationRecord
  has_many :users
  has_many :gifts
  has_many :donors
  has_many :subscriptions
  has_one :form
  has_many :conversions
end
