require 'clarifai/configuration'

module Clarifai
  def self.configuration
    @configuration ||= self::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end