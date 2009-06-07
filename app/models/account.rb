class Account < ActiveRecord::Base
  belongs_to :user
  has_many :envelopes, :dependent => :destroy
  
  validates_presence_of :api_id, :api_name, :api_user_id
  
  encrypts :api_id, :api_name, :api_password, :api_email, :api_user_id
end