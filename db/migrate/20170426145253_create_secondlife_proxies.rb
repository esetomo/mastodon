class CreateSecondlifeProxies < ActiveRecord::Migration[5.0]
  def change
    create_table :secondlife_proxies do |t|
      t.string :domain, null: false
      t.string :client_id, null: false
      t.string :client_secret, null: false
      t.timestamps
      t.index :domain
    end
  end
end
