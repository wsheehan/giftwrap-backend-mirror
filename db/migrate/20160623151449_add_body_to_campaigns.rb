class AddBodyToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :body, :string
  end
end
