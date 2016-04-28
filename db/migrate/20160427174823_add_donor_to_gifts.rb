class AddDonorToGifts < ActiveRecord::Migration
  def change
    add_reference :gifts, :donor, index: true, foreign_key: true
  end
end
