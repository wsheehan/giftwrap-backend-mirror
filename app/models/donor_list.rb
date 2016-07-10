class DonorList < ApplicationRecord

  # Associations
  belongs_to :campaign
  has_and_belongs_to_many :donors

end
