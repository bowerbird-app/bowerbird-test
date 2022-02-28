require 'clarifai'

Clarifai.configure do |config|
  config.token = Rails.application.credentials.dig(Rails.env.to_sym, :clarifai, :token)
end