# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :integer
#  password_digest :string
#

class User < ApplicationRecord

  # Associations
  belongs_to :client
  has_many :campaigns

  # bcrypt backed password
  has_secure_password

  # Validations
  validates :email, uniqueness: true

end
