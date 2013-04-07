# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Task::Application.config.secret_token = 'b04dc6c2cdb0e7df637065013fbaca73ef41a55f8c6fef991649715f4f5cff5ddc9dae3faf4b38b8adc29407c8de14abd413c79d45d3e15e8192dbd838b36929'
