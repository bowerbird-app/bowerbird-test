FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.unique.word }
    user_id { create(:user).id }
  end
end