# Copyright (C) DocuSign, Inc.  All rights reserved.
# 
# This source code is intended only as a supplement to DocuSign SDK 
# and/or on-line documentation.
# 
# This sample is designed to demonstrate DocuSign features and is not intended 
# for production use. Code and policy for a production application must be 
# developed to meet the specific data and security requirements of the 
# application.
# 
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
# KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
# PARTICULAR PURPOSE.

class Account < ActiveRecord::Base
  belongs_to :user
  has_many :envelopes, :dependent => :destroy
  
  validates_presence_of :api_id, :api_name, :api_user_id
  
  def ds_connection
    @connection ||= Docusign::Base.login(
      :user_name    => api_user_id,
      :password     => api_password,
      :endpoint_url => Docusign::Config[:default_endpoint_url]
    )
  end
end