class RemoveSchoolIdFromDonors < ActiveRecord::Migration[5.0]
  def change
    remove_column :donors, :school_id
    add_reference :donors, :client, index: true, foreign_key: true
  end
end
