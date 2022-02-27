require 'rails_helper'

RSpec.describe ImageTag, type: :model do
  subject { FactoryBot.create(:image_tag) }
  it { should belong_to(:tag) }
  it { should belong_to(:image) }
  it { should validate_presence_of(:probability) }
  it { should validate_uniqueness_of(:tag_id).scoped_to(:image_id) }
end
