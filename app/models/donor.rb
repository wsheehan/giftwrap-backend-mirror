class Donor < ActiveRecord::Base

	# Associations
	has_many :gifts
	belongs_to :school
	has_and_belongs_to_many :campaigns

	# Validations
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true

end
