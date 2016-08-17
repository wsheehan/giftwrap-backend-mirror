class AddReferenceToMetricFormConversion < ActiveRecord::Migration[5.0]
  def change
    add_reference :metric_form_conversions, :metric, foreign_key: true
    remove_reference :metric_form_conversions, :school
  end
end
