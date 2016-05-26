class AddDonorListIdToCampaign < ActiveRecord::Migration
  def change
    add_reference :campaigns, :donor_list, index: true, foreign_key: true
  end
end
