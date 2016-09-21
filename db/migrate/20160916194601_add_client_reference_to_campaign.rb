class AddClientReferenceToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_reference :campaigns, :client, foreign_key: true
    remove_reference :campaigns, :school
  end
end
