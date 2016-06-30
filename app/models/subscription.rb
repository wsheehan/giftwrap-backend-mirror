class Subscription < ActiveRecord::Base
  has_many :donors
end
