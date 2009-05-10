class CreateEnvelopes < ActiveRecord::Migration
  def self.up
    create_table :envelopes do |t|
      t.string    :account_id
      t.string    :recipient_name
      t.string    :recipient_email
      t.string    :subject
      t.string    :email_blurb
      t.string    :document_file_name
      t.string    :document_content_type
      t.integer   :document_file_size
      t.datetime  :document_updated_at
      t.string    :ds_id
      t.string    :ds_status
      t.datetime  :status_updated_at
      t.string    :state
      t.integer   :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :envelopes
  end
end
