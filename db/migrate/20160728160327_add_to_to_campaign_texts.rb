class AddToToCampaignTexts < ActiveRecord::Migration[5.0]
  def change
    add_column :campaign_texts, :to, :string
  end
end
