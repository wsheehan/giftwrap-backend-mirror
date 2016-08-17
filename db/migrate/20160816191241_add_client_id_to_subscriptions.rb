class AddClientIdToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_reference :subscriptions, :client, foreign_key: true
    remove_reference :subscriptions, :school
  end
end
