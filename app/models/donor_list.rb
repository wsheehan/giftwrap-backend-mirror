# == Schema Information
#
# Table name: donor_lists
#
#  id          :integer          not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :integer
#  description :string
#

class DonorList < ApplicationRecord

  # Associations
  belongs_to :client
  has_many :campaigns
  has_and_belongs_to_many :donors

  # PG search implementation
  include PgSearch
  pg_search_scope :search_records, against: [:title, :description]

end
