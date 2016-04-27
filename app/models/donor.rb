class Donor < ActiveRecord::Base
	has_many :gifts
	belongs_to :school

	# The Campaign Donor Relationship is something we need to discuss...
  	# has_many :campaigns
end
