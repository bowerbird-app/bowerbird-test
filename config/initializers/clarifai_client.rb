require 'clarifai_client'

ClarifaiClient.configure do |config|
  config.api_base_url             = ENV['CLARIFAI_API_BASE_URL']
  config.api_key                  = ENV['CLARIFAI_API_KEY']
  config.model_id                 = ENV['CLARIFAI_MODEL_ID']
  config.model_version_id         = ENV['CLARIFAI_MODEL_VERSION_ID']
end