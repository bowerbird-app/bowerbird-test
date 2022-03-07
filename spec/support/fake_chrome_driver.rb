require 'sinatra/base'

class FakeChromeDriver < Sinatra::Base

  # stubbing the image recognition API
  get '/:release_version' do
    content_type :text
    status 200
    '98.0.4758.102'
  end

end