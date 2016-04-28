class CreateCampaignDonorTable < ActiveRecord::Migration
  def change
    create_table :campaigns_donors, id: false do |t|
    	t.belongs_to :campaign, index: true
    	t.belongs_to :donor, index: true
    end
  end
end
