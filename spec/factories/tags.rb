FactoryBot.define do
  factory :tag do
    name { Faker::Adjective.positive }
  end
end
