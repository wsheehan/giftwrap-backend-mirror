class AddSchoolToDonors < ActiveRecord::Migration
  def change
    add_reference :donors, :school, index: true, foreign_key: true
  end
end
