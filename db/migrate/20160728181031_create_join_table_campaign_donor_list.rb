class CreateJoinTableCampaignDonorList < ActiveRecord::Migration[5.0]
  def change
    create_join_table :campaigns, :donor_lists do |t|
      t.index [:campaign_id, :donor_list_id]
      t.index [:donor_list_id, :campaign_id]
    end
  end
  remove_reference :campaigns, :donor_list, index: true
end
