class Donor < ActiveRecord::Base
	after_create :create_key

	# Associations
	has_many :gifts
	belongs_to :school
	has_and_belongs_to_many :campaigns

	# Validations
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true

  private

  	def create_key
  		self.key = SecureRandom.urlsafe_base64(16)
  	end

end
