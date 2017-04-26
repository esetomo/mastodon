class CreateSecondlifeScripts < ActiveRecord::Migration[5.0]
  def change
    create_table :secondlife_scripts do |t|
      t.references :secondlife_account
      t.string :prim_key
      t.string :script_url
      t.timestamps
      t.index :prim_key
    end
  end
end
