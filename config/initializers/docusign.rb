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

Docusign::Config = HashWithIndifferentAccess.new(YAML.load_file("#{RAILS_ROOT}/config/docusign.yml")[RAILS_ENV])

# We're using EzCrypto to generate a key which can be used for
# encoding and decoding user information. We don't want to store
# user credentials in plaintext. Please replace the following
# password and salt with something a bit more secure.
Docusign::Config[:crypt_key] = EzCrypto::Key.with_password "Super Secret", "Salt Taffy"