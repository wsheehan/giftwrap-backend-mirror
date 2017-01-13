class Donor < ApplicationRecord

  # Associations
  has_many :gifts
  belongs_to :client
  belongs_to :subsciption
  belongs_to :campaign
  has_many :campaign_conversions, class_name: "Metric::CampaignConversion"
  has_many :form_conversions, class_name: "Metric::FormConversion"
  has_and_belongs_to_many :donor_lists

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  # PG search implementation
  include PgSearch
  pg_search_scope :search_records, against: [:first_name, :last_name, :email]

  def create_key
    update_attribute :key, SecureRandom.urlsafe_base64(16)
  end

  def suggested_gift
    ((gifts.last.total.to_f * 1.25) + 10).round(-1)
  end

  def has_payment_info?
    braintree_customer_id.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def get_payment_info
    braintree_customer = Braintree::Customer.find(braintree_customer_id)
    payment_method = Braintree::PaymentMethod.find(braintree_customer.payment_methods[0].token)
    if payment_method.class == Braintree::PayPalAccount
      { "payment_method" => "Paypal", "paypal_email" => payment_method.email }
    else
      { "payment_method" => "Credit Card", "masked_number" => payment_method.masked_number, "credit_image_url" => payment_method.image_url }
    end
  end

end
