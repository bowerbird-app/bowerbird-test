require 'spec_helper'
require 'clarifai'

describe 'clarifai' do
  it "can configure token and base url" do
    Clarifai.configure do |config|
      config.token = "ABC"
      config.base_url = "http://www.fake_url.com"
    end

    expect(Clarifai.configuration.token).to eq("ABC")
    expect(Clarifai.configuration.base_url).to eq("http://www.fake_url.com")
  end
end