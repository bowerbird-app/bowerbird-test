FactoryBot.define do
  factory :image do
    name { Faker::Lorem.word.titleize }
    description { Faker::Lorem.paragraph }
    file { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/test-photo.jpg'))) }
    user { create(:user) }
  end
end
