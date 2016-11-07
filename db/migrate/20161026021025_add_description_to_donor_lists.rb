class AddDescriptionToDonorLists < ActiveRecord::Migration[5.0]
  def change
    add_column :donor_lists, :description, :string
  end
end
