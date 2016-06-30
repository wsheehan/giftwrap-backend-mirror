class AddSubscriptionReferencesToDonors < ActiveRecord::Migration
  def change
    add_reference :donors, :subscription, index: true, foreign_key: true
    add_reference :subscriptions, :school, index: true, foreign_key: true
  end
end
