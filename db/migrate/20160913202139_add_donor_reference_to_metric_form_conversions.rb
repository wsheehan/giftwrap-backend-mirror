class AddDonorReferenceToMetricFormConversions < ActiveRecord::Migration[5.0]
  def change
    add_reference :metric_form_conversions, :donor, foreign_key: true
  end
end
