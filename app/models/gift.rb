class Gift < ActiveRecord::Base

	# Associations
  belongs_to :school
  belongs_to :donor

  # Validations
	validates :total, presence: true
	validates :donor_id, presence: true
	
end
