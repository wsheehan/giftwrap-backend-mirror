class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.references :user, index: true, foreign_key: true
      t.references :school, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
