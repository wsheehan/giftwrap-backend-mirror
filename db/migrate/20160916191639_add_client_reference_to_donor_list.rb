class AddClientReferenceToDonorList < ActiveRecord::Migration[5.0]
  def change
    add_reference :donor_lists, :client, foreign_key: true
  end
end
