class AddCampaignReferenceToDonors < ActiveRecord::Migration[5.0]
  def change
    add_reference :donors, :campaign, index: true, foreign_key: true
  end
end
