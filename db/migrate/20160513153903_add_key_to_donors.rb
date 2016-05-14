class AddKeyToDonors < ActiveRecord::Migration
  def change
    add_column :donors, :key, :string
  end
end
