class DonorList < ApplicationRecord

  # Associations
  belongs_to :client
  has_many :campaigns
  has_and_belongs_to_many :donors

  # PG search implementation
  include PgSearch
  pg_search_scope :search_records, against: [:title, :description]

end
