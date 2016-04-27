class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :total
      t.references :school, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
