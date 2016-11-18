class RemoveDonorListsCampaignsJoinTable < ActiveRecord::Migration[5.0]
  def change
    drop_join_table :campaigns, :donor_lists
  end
end
