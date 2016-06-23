class Campaign < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :school
  has_many :donor_lists

  def donors
    donor_list.donors
  end

end
