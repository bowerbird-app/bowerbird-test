require 'rails_helper'
require 'clarifai_client'

RSpec.describe ClarifaiClient, type: :model do

  describe '#call' do
    
    it 'should return true if the api call was successful' do
      image_url = attributes_for(:image)[:remote_file_url]
      client = ClarifaiClient.new
      expect(client.call(image_url)).to be_truthy
    end

  end

  describe '#tags' do
    
    it 'should return an array of tags' do
      image_url = attributes_for(:image)[:remote_file_url]
      client = ClarifaiClient.new
      client.call(image_url)
      expect(client.tags).to be_a(Array)
    end

  end

end