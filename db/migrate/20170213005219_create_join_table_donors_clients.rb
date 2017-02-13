class CreateJoinTableDonorsClients < ActiveRecord::Migration[5.0]
  def change
    create_join_table :donors, :clients do |t|
      # t.index [:donor_id, :client_id]
      # t.index [:client_id, :donor_id]
    end
  end
end
