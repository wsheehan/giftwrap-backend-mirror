class Campaign < ApplicationRecord

  # Associations
  belongs_to :user
  belongs_to :school
  has_and_belongs_to_many :donor_lists

  has_one :text, class_name: 'Campaign::Text'
  has_one :email, class_name: 'Campaign::Email'

  def donors
    donor_lists.donors
  end

end
