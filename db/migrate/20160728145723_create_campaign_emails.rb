class CreateCampaignEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_emails do |t|
      t.references :campaign, foreign_key: true
      t.string :title
      t.string :body

      t.timestamps
    end
    remove_column :campaigns, :body
    remove_column :campaigns, :title
  end
end
