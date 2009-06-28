module TemplateParser
  module ClassMethods
    
  end
  
  module InstanceMethods
    def save_attached_files
      super
      logger.info("Just called super!")
      if has_template?
        doc = Nokogiri.parse File.read(document.path)

        attribute_mapping = {
          :name   => 'UserName',
          :email  => 'Email',
          :role   => 'RoleName',
          :recipient_type => 'Type'
        }

        recipient_nodes = doc.search('Recipients')

        recipient_nodes.each do |recipient_node|
          recipient = Recipient.new(:for_template => true)

          attribute_mapping.each do |key, value|
            recipient.write_attribute key, recipient_node.at(value).text.strip if recipient_node.at(value)
          end

          self.recipients << recipient
          recipient.save_without_validation
        end
      end
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end