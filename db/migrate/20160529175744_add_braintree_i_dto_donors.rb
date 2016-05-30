class AddBraintreeIDtoDonors < ActiveRecord::Migration
  def change
    add_column :donors, :braintree_customer_id, :string
  end
end
