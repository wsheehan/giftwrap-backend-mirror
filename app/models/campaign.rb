class Campaign < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :school
  has_one :donor_list

  def donors
    donor_list.donors
  end

end
