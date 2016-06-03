class AddDesignationToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :designation, :string, array: true
    add_column :gifts, :designation, :string
  end
end
