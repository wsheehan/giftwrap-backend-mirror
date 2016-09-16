class DonorList < ApplicationRecord

  # Associations
  belongs_to :client

  has_and_belongs_to_many :campaigns
  has_and_belongs_to_many :donors

end
