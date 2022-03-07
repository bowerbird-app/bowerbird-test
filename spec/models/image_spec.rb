require 'rails_helper'

RSpec.describe Image, type: :model do
  context 'validation test' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:file) }

    it 'save successfully' do
      image = Image.new attributes_for(:image)
      expect(image.save).to eq(true)
    end
  end

  context 'association test' do
    it { should belong_to(:user) }
    it { should have_many(:image_tags).dependent(:destroy) }
    it { should have_many(:tags).through(:image_tags) }
  end
end
