class Campaign < ActiveRecord::Base
  belongs_to :user
  belongs_to :school

  has_and_belongs_to_many :donors
end
