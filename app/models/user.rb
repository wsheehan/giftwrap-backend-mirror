class User < ActiveRecord::Base
  belongs_to :school
  has_many :campaigns
end
