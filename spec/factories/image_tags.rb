FactoryBot.define do
  factory :image_tag do
    image { create(:image) }
    tag { create(:tag) }
    probability { Faker::Number.within(range: 0.0..1.0) }
  end
end
