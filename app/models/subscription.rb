class Subscription < ActiveRecord::Base
  has_many :donors
  belongs_to :school
end
