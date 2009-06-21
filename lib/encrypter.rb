# Module providing declarative encryption of ActiveRecord models
# 
# Example
# 
# class Widget < ActiveRecord::Base
#   encrypts :api_password, :secret_info
# end

module Encrypter
  def encrypts(*args)
    args.each do |arg|
      class_eval <<-EOS
        def #{arg}
          self[:#{arg}].blank? ? self[:#{arg}] : Docusign::Config[:crypt_key].decrypt64(self[:#{arg}])
        end
        
        def #{arg}=(value)
          self[:#{arg}] = value.blank? ? value : Docusign::Config[:crypt_key].encrypt64(value)
        end
      EOS
    end
  end
end