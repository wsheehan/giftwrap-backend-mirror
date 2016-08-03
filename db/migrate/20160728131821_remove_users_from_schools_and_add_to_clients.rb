class RemoveUsersFromSchoolsAndAddToClients < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :school_id
    add_reference :users, :client, index: true, foreign_key: true
  end
end
