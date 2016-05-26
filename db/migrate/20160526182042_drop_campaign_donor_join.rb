class DropCampaignDonorJoin < ActiveRecord::Migration
  def change
    drop_table :campaigns_donors
  end
end
