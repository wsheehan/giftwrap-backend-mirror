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
#  admin           :boolean
#  remember_digest :string
#

class User < ApplicationRecord
  attr_accessor :remember_token

  # Associations
  belongs_to :client
  has_many :campaigns

  # bcrypt backed password
  has_secure_password

  # Validations
  validates :email, uniqueness: true

  def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
      SecureRandom.urlsafe_base64
  end

  def admin?
    admin
  end

  def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def new_authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
      update_attribute(:remember_digest, nil)
  end
  
end
