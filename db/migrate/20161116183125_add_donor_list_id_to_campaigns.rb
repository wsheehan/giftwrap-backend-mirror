class AddDonorListIdToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_reference :campaigns, :donor_list, foreign_key: true
  end
end
