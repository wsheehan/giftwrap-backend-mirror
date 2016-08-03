class CreateClientPolicies < ActiveRecord::Migration[5.0]
  def change
    create_table :client_policies do |t|
      t.string :app_id,           null: false
      t.string :app_public_key
      t.string :app_secret_key
      t.references :client

      t.timestamps
    end
  end
end
