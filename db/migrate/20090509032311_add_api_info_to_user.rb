class AddApiInfoToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :api_login, :string
    add_column :users, :api_password, :string
  end

  def self.down
    remove_column :users, :api_password
    remove_column :users, :api_login
  end
end
