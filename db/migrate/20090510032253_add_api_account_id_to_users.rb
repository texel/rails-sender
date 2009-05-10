class AddApiAccountIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :api_account_id, :string
  end

  def self.down
    remove_column :users, :api_account_id
  end
end
