class Campaign < ActiveRecord::Base
  belongs_to :user
  belongs_to :school

  # The Campaign Donor Relationship is something we need to discuss...
  # has_many :donors
end
