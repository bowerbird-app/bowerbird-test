FactoryBot.define do
  factory :image do
    name            { Faker::Lorem.words(number: 4).join(' ') }
    remote_file_url { 'https://loremflickr.com/300/300/building' }

    trait :from_fixture do
      file { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/glass-building.jpeg")) }
    end
  end
end