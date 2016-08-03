class RemoveFormFromSchoolAndAddToClient < ActiveRecord::Migration[5.0]
  def change
    remove_column :forms, :school_id
    add_reference :forms, :client, index: true, foreign_key: true
  end
end
