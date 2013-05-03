# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
UserGroup::Application.config.secret_token = ENV['RAILS_SECRET_TOKEN'] || '2f4b6cad61fc17102d3c9ccc6ff037e9d7ea653c3a0dd4fc484406e21519124e040b4e5d3d1812551a9bac251e59dc459e0060234733d0b85f5f40da50f08df9'
