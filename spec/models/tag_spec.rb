require 'rails_helper'

RSpec.describe Tag, type: :model do
  context 'validation test' do
    it { should validate_presence_of(:name) }
    it do
      create(:tag)
      should validate_uniqueness_of(:name).scoped_to(:user_id)
    end

    it 'save successfully' do
      tag = Tag.new attributes_for(:tag)
      expect(tag.save).to eq(true)
    end
  end

  context 'association test' do
    it { should belong_to(:user) }
    it { should have_many(:image_tags) }
    it { should have_many(:images).through(:image_tags) }
  end
end