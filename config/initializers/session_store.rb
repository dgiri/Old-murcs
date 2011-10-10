# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_murcsloot_session',
  :secret      => 'a6300a4768501022a6306376f4377c6ce29857b7c9dc90f7c99f9905b351cca0f1f2630e4b542115185b9dd7596979fc03b3c9d3a0cc69910483262b51da27d5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
