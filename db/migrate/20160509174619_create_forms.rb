class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.references :school, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
