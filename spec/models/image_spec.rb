require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:image_tags) }
  it { should have_many(:tags).through(:image_tags) }

  # Test file types
  # Should only allow images
  context "extension whitelist" do
    it 'should allow file with image extensions' do
      expect{ FactoryBot.create(:image) }.not_to raise_error
    end

    it 'should not allow files without image extensions' do
      expect do
        FactoryBot.create(:image, file: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/test-gif.gif'))))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
