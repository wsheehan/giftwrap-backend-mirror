class AddInfoToDonors < ActiveRecord::Migration[5.0]
  def change
    add_column :donors, :affiliation, :string
    add_column :donors, :class_year, :integer
  end
end
