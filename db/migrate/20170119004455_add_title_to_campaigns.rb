class AddTitleToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :campaigns, :title, :string
  end
end
