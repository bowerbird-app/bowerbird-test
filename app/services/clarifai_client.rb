class ClarifaiClient
  include ActiveSupport::Configurable
  
  MINIMUM_PREDICTION_VALUE = 0.9

  def initialize(opt = {})
    @minimum_prediction_value = opt[:minimum_prediction_value] || MINIMUM_PREDICTION_VALUE
    @connection = Excon.new(ClarifaiClient.config[:api_base_url])
  end

  def call(image_url)
    @response_body = nil # reset response_body
    @image_url = image_url
    response = @connection.post(
        path: api_path,
        headers: request_headers,
        body: request_body.to_json,
        expect: [200]
      )
    @response_body = JSON.parse(response.body)
    return api_call_success?
  end

  def tags
    extracted_tags || []
  end

  private
    def api_path
      # model_version_id is optional
      # https://docs.clarifai.com/api-guide/predict/images
      if ClarifaiClient.config[:model_version_id].present?
        "/v2/models/#{ClarifaiClient.config[:model_id]}/versions/#{ClarifaiClient.config[:model_version_id]}/outputs"
      else
        "/v2/models/#{ClarifaiClient.config[:model_id]}/outputs"
      end
    end

    def request_headers
      {
        'Authorization': "Key #{ClarifaiClient.config[:api_key]}",
        'Content-Type': 'application/json'
      }
    end

    def request_body
      {
        inputs: [
          {
            data: {
              image: {
                url: @image_url
              }
            }
          }
        ],
        model: {
          output_info: {
            output_config: {
              min_value: @minimum_prediction_value
            }
          }
        }
      }
    end

    # making sure the API call and the detection result are both successful
    def api_call_success?
      @response_body&.dig('status', 'code') == 10000 &&
      detection_result.dig('status', 'code') == 10000
    end

    # clarifai is accepting array of images and returning multiple outputs, 
    # but we just want to find the one correspond to the image_url that we passed in
    def detection_result
      @response_body&.dig('outputs')&.detect { |output| output.dig('input', 'data', 'image', 'url') == @image_url }
    end

    # return the tags of the image
    def extracted_tags
      detection_result&.dig('data', 'concepts')&.map { |concept| { name: concept['name'], probability: concept['value'] } }
    end
end
