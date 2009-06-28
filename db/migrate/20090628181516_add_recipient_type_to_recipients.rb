class AddRecipientTypeToRecipients < ActiveRecord::Migration
  def self.up
    add_column :recipients, :recipient_type, :string, :default => 'Signer'
  end

  def self.down
    remove_column :recipients, :recipient_type
  end
end
