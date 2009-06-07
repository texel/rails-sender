class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :api_id
      t.string :api_name
      t.string :api_password
      t.string :api_email
      t.string :api_user_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
