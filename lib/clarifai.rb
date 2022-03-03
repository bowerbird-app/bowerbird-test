require 'clarifai/configuration'
require 'clarifai/general_image_recognition'
require 'faraday'

module Clarifai
  # Fetches exisiting configuration, if not, it will create one
  # Configuration shall be managed by
  #
  # Clarifai.configure do |config|
  #   config.token = 'your-token'
  #   config.base_url = 'url'
  # end
  #
  # Configuration only accepts token and base_url
  def self.configuration
    @configuration ||= self::Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.base_request
    @base_request ||= Faraday.new(
      url: configuration.base_url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Key #{configuration.token}"
      }
    )
  end
end