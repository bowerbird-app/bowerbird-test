if !Rails.env.test?
  CarrierWave.configure do |config|
    aws_credentials = Rails.application.credentials.dig(Rails.env.to_sym, :aws)

    config.storage = :aws
    config.aws_bucket = aws_credentials.dig(:bucket_name)
    config.aws_acl = 'private'
    # config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

    config.aws_credentials = {
      access_key_id: aws_credentials.dig(:aws_access_key_id),
      secret_access_key: aws_credentials.dig(:aws_secret_access_key),
      region: aws_credentials.dig(:region),
      stub_responses: Rails.env.test?
    }

    config.aws_attributes = -> { {
      expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=604800'
    } }
  end
end