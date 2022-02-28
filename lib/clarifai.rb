require 'clarifai/configuration'
require 'clarifai/general_image_recognition'
require 'faraday'

module Clarifai
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