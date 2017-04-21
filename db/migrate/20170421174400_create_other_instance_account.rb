class CreateOtherInstanceAccount < ActiveRecord::Migration[5.0]
  def change
    create_table :other_instance_accounts do |t|
      t.references :account
      t.string "uid", null: false
      t.string "url", null: false
      t.index :uid
    end
  end
end
