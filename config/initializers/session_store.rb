# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_laizen_session',
  :secret      => '81bff3ec1079329e6bf73428a9e71e9d6a54a936f131ca54d2560e59e7924557a6cdcee47861aa1574277890d5b66b441758f9dfb2f8870c3d998a174b602b5b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
