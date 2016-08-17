class AddReferencesToClient < ActiveRecord::Migration[5.0]
  def change
    add_reference :gifts, :client, index: true, foreign_key: true
    remove_reference :gifts, :school
  end
end
