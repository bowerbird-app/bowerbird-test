CarrierWave.configure do |config|
  # For an application which utilizes multiple servers but does not need caches persisted across requests,
  # uncomment the line :file instead of the default :storage.  Otherwise, it will use AWS as the temp cache store.
  # config.cache_storage = :file

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
    config.asset_host = 'http://example.com'
  else
    config.storage = :fog
    config.fog_credentials = {
      provider:              'AWS',                        
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],                
      aws_secret_access_key: ENV['AWS_ACCESS_SECRET'],             
      region:                ENV['S3_REGION']
    }
    config.fog_directory  = ENV['S3_BUCKET_NAME']
    config.fog_public     = false 
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  end
end