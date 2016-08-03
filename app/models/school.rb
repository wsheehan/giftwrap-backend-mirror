class School < ApplicationRecord
  has_many :gifts
  has_many :subscriptions
  has_many :conversions
end
