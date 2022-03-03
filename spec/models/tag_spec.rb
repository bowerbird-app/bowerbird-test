require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_many(:image_tags) }
  it { should have_many(:images).through(:image_tags) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
