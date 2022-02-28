module Clarifai
  class Configuration
    attr_accessor :token, :base_url

    def initialize(token: nil, base_url: "https://api.clarifai.com")
      @token = token
      @base_url = base_url
    end
  end
end