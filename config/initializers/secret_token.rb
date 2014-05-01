# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
App::Application.config.secret_key_base = '131a56356b3969ca72634a23f968e3711f361dd4059037dd9b871c07a14e54ad9af5fb6aa0c66a6f19cc428e4492d13ce2dcf31403df921b70940f6ca6084ab9'
