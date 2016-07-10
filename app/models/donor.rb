class Donor < ApplicationRecord

  # Associations
  has_many :gifts
  belongs_to :school
  has_and_belongs_to_many :donor_lists
  belongs_to :subsciption

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def create_key
    update_attribute :key, SecureRandom.urlsafe_base64(16)
  end

  def suggested_gift
    gifts.last.total.to_f * 1.25
  end

  def has_payment_info?
    braintree_customer_id
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
