class AddCampaignToGifts < ActiveRecord::Migration
  def change
    add_reference :gifts, :campaign, index: true, foreign_key: true
  end
end
