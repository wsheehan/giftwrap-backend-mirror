class DonorList < ApplicationRecord

  # Associations
  has_and_belongs_to_many :campaigns
  has_and_belongs_to_many :donors

end
