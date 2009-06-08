class Recipient < ActiveRecord::Base
  belongs_to :envelope
  
  validates_presence_of :email
end
