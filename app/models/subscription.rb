class Subscription < ApplicationRecord
  has_many :donors
  belongs_to :school
end
