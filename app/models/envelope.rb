class Envelope < ActiveRecord::Base
  
  # Let's make the envelope stateful!
  include AASM
  aasm_column         :state
  aasm_initial_state  :pending
  
  aasm_state  :pending
  aasm_state  :sent
  
  aasm_event :send_envelope do
    transitions :from => :pending, :to => :sent
  end        
  
  belongs_to :account
  has_many :recipients
  accepts_nested_attributes_for :recipients, :allow_destroy => true
      
  has_attached_file :document
  
  validates_presence_of :account_id, :recipient_email, :recipient_name, :subject
    
  def to_ds_envelope
    ds_envelope = Docusign::Envelope.new
    
    ds_envelope.accountId   = self.account.api_id
    ds_envelope.subject     = self.subject
    ds_envelope.emailBlurb  = self.email_blurb
    
    ds_document = Docusign::Document.new
    ds_document.iD     = self.id
    ds_document.name   = self.document_file_name
    ds_document.pDFBytes = 
      Base64.encode64(
        File.open(self.document.path) do |doc|
          doc.read
        end
      )
    ds_document.fileExtension = File.extname(document.path)
        
    ds_envelope.documents = [ds_document]
        
    ds_recipient = Docusign::Recipient.new
    ds_recipient.email       = self.recipient_email
    ds_recipient.userName    = self.recipient_name
    ds_recipient.type        = Docusign::RecipientTypeCode::Signer
    ds_recipient.iD          = self.id
    ds_recipient.requireIDLookup = false
    
    ds_envelope.recipients = [ds_recipient]
    
    ds_envelope
  end
end
