class Metric::Campaign::Conversion < ApplicationRecord

  # Associations
  belongs_to :campaign
  belongs_to :donor
  belongs_to :metric

end
