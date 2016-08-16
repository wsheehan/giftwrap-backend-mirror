class RenameConversion < ActiveRecord::Migration[5.0]
  def change
    rename_table :conversions, :metric_form_conversions
  end
end
