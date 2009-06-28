class AddForTemplateToRecipient < ActiveRecord::Migration
  def self.up
    add_column :recipients, :for_template, :boolean, :default => false
  end

  def self.down
    remove_column :recipients, :for_template
  end
end
