require 'sinatra/base'

class FakeClarifai < Sinatra::Base

  # stubbing the image recognition API
  post '/v2/models/:model_id/outputs' do
    @request_body = JSON.parse(request.body.read)
    content_type :json
    status 200
    image_recognition_response.to_json
  end

  post '/v2/models/:model_id/versions/:model_version_id/outputs' do
    @request_body = JSON.parse(request.body.read)
    content_type :json
    status 200
    image_recognition_response.to_json
  end

  private
    def image_recognition_response
      {
        "status": {
          "code": 10000, 
          "description": "Ok", 
          "req_id": SecureRandom.alphanumeric(32)
        }, 
        "outputs": outputs_response
      }
    end

    def random_concepts
      concepts = []
      rand(1..5).times do
        concepts << {
          "id": "ai_#{SecureRandom.alphanumeric(8)}",
          "name": Faker::Lorem.unique.word,
          "value": rand(0.0..1.0),
          "app_id": "main"
        }
      end
      return concepts
    end

    def input_urls
      @request_body.dig('inputs').map { |input| input.dig('data', 'image', 'url') }
    end

    def outputs_response
      # we extracts all the input image urls from the request body
      # and then we return the response body for each of them
      input_urls.map do |url|
        {
          "id": SecureRandom.alphanumeric(32),
          "status": {
            "code": 10000, 
            "description": "Ok"
          },
          "created_at": Time.current,
          "model": {
            "id": params['model_id'], 
            "name": "general", 
            "created_at": "2016-03-09T17:11:39.608845Z", 
            "modified_at": "2022-02-18T13:50:21.902783Z", 
            "app_id": "main", 
            "output_info": {
              "output_config": {
                "concepts_mutually_exclusive": false, 
                "closed_environment": false, 
                "max_concepts": 0, 
                "min_value": 0
              }, 
              "message": "Show output_info with: GET /models/{model_id}/output_info", 
              "fields_map": {
                "concepts": "softmax"
              }
            }, 
            "model_version": {
              "id": "aa7f35c01e0642fda5cf400f543e7c40", 
              "created_at": "2018-03-06T21:10:24.454834Z", 
              "status": {
                "code": 21100, 
                "description": "Model is trained and ready"
              }, 
              "visibility": {
                "gettable": 50
              }, 
              "app_id": "main", 
              "user_id": "clarifai", 
              "metadata": {}
            }, 
            "user_id": "clarifai", 
            "input_info": {
              "fields_map": {
                "image": "images"
              }
            }, 
            "train_info": {}, 
            "model_type_id": "visual-classifier", 
            "visibility": {
              "gettable": 50
            }, 
            "notes": "", 
            "toolkits": [], 
            "star_count": 0, 
            "import_info": {}
          },
          "input": {
            "id": SecureRandom.alphanumeric(32), "data": {
              "image": {
                "url": url
              }
            }
          },
          "data": {
            "concepts": random_concepts
          }
        }
      end
    end
end