class AddHeaderImageToCampaignEmail < ActiveRecord::Migration[5.0]
  def change
    add_column :campaign_emails, :header_image, :string
  end
end
