class AddReferenceToFormConversions < ActiveRecord::Migration[5.0]
  def change
    add_reference :metric_form_conversions, :metric_campaign_conversions, foreign_key: true
    add_reference :metric_form_conversions, :gift, foreign_key: true
    remove_column :metric_form_conversions, :converted
    remove_column :metric_form_conversions, :identifier
  end
end
