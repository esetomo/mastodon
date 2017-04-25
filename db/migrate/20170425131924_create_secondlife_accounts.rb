class CreateSecondlifeAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :secondlife_accounts do |t|
      t.references :user
      t.string :key
      t.string :user_name
      t.string :display_name
      t.string :legacy_name
      t.string :token
      t.timestamps
      t.index :key
      t.index :token      
    end
  end
end
