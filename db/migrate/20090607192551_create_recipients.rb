class CreateRecipients < ActiveRecord::Migration
  def self.up
    create_table :recipients do |t|
      t.integer :envelope_id
      t.string :name
      t.string :email
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :recipients
  end
end
