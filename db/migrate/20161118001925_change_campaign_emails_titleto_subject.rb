class ChangeCampaignEmailsTitletoSubject < ActiveRecord::Migration[5.0]
  def change
    rename_column :campaign_emails, :title, :subject
  end
end
