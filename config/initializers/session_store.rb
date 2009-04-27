# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_docusign-example-3-0-10_session',
  :secret      => 'b8acb4aaf03ca25126359151c9bd685bad19296f44f5c48f55fc7e2f3fd81d0777f61e81bd7e648669e8b1d7ffde7cdc40451373a30bc1d6c34cb81d1f9660e1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
