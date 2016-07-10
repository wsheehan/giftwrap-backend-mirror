class CreateConversions < ActiveRecord::Migration[5.0]
  def change
    create_table :conversions do |t|
      t.boolean :converted, default: false
      t.datetime :hit_time
      t.string :identifier
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
