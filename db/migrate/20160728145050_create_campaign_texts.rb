class CreateCampaignTexts < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_texts do |t|
      t.references :campaign, foreign_key: true
      t.string :body
      t.string :from

      t.timestamps
    end
  end
end
