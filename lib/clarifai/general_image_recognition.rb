module Clarifai
  class GeneralImageRecognition
    MODEL_ID = "general-image-recognition"
    MODEL_VERSION_ID = 'aa7f35c01e0642fda5cf400f543e7c40'

    def self.get_output(url)
      response = self.module_parent.base_request.post(self.endpoint) do |req|
        req.body = {
          inputs: [
            data: {
              image: {
                url: url
              }
            }
          ]
        }.to_json
      end

      JSON.parse(response.body, symbolize_names: true)
    end

    private
      def self.endpoint
        "/v2/models/#{MODEL_ID}/versions/#{MODEL_VERSION_ID}/outputs"
      end
  end
end