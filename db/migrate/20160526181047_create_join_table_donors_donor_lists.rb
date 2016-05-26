class CreateJoinTableDonorsDonorLists < ActiveRecord::Migration
  def change
    create_join_table :donors, :donor_lists do |t|
      t.index :donor_id
      t.index :donor_list_id
    end
  end
end
