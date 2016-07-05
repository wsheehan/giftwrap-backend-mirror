class AddSubscriptionStartToDonors < ActiveRecord::Migration
  def change
    add_column :donors, :subscription_start, :date
    add_column :subscriptions, :interval, :integer
    add_column :donors, :subscription_total, :string
  end
end
