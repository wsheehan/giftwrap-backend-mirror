class CreateDonorLists < ActiveRecord::Migration
  def change
    create_table :donor_lists do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
