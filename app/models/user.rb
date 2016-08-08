class User < ApplicationRecord

  # Associations
  belongs_to :school
  has_many :campaigns

  # bcrypt backed password
  has_secure_password

end
