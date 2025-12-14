# config/puma.rb
# Render 512MB safe configuration

workers 1

threads 2, 2

port ENV.fetch("PORT", 3000)

environment ENV.fetch("RAILS_ENV") { "production" }

preload_app!

plugin :tmp_restart