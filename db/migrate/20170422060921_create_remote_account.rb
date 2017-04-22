class CreateRemoteAccount < ActiveRecord::Migration[5.0]
  def change
    create_table :remote_accounts do |t|
      t.references :user
      t.references :account
    end
  end
end
