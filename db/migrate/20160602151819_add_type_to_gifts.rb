class AddTypeToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :gift_type, :string
  end
end
