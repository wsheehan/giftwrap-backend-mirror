class School < ActiveRecord::Base
	has_many :users
	has_many :gifts
	has_many :donors
	has_one :form
end
