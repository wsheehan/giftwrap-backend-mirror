class CreateClientUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :client_urls do |t|
      t.string :root_url,     null: false
      t.references :client

      t.timestamps
    end
  end
end
