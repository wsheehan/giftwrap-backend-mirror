class AddGiftFrequencyToDonors < ActiveRecord::Migration
  def change
    add_column :donors, :gift_frequency, :string
  end
end
