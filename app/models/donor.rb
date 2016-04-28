class Donor < ActiveRecord::Base
	has_many :gifts
	belongs_to :school

	has_and_belongs_to_many :campaigns
end
