class CreateMastodonClient < ActiveRecord::Migration[5.0]
  def change
    create_table :mastodon_clients do |t|
      t.string "domain", null: false
      t.string "client_id", null: false
      t.string "client_secret", null: false
    end
  end
end
