class User < ApplicationRecord

  # Associations
  belongs_to :client
  has_many :campaigns

  # bcrypt backed password
  has_secure_password

  # Validations
  validates :email, uniqueness: true

end
