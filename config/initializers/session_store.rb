# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_stadiumchoir_session',
  :secret      => '27c711fad73d5d04a3f682567b2ce6f51a69e2fddc52f53390b9c46666477fc1416781549186a2a3388c1e521fcab90f930cda8628200b968704507db77a654c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
