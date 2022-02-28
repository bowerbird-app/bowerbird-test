require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:image_tags) }
  it { should have_many(:tags).through(:image_tags) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:file) }

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

  context "class methods" do
    context "tags_with_count method" do
      before do
        2.times { FactoryBot.create(:tag) }

        Tag.all.each do |tag|
          3.times { FactoryBot.create(:image_tag, tag: tag) }
        end
      end

      it "groups tags and amount of images in it" do
        expected_output = Tag.all.map do |tag|
          [tag.name, tag.images.size]
        end.to_h

        expect(Image.tags_with_count).to include(expected_output)
      end

      it "groups tags and amount of images in it with total" do
        expected_output = Tag.all.map do |tag|
          [tag.name, tag.images.size]
        end.to_h

        expected_output["All"] = Image.all.size

        expect(Image.tags_with_count(with_total: true)).to include(expected_output)
      end
    end
  end

  context "scopes" do
    context "filter by tag name" do
      before do
        2.times { FactoryBot.create(:tag) }
        5.times { Tag.all.each { |tag| FactoryBot.create(:image_tag, tag: tag) } }
      end

      it "should return all if params is empty" do
        expect(Image.by_tag_name(nil)).to match_array(Image.all)
      end

      it "should return all if params is all" do
        expect(Image.by_tag_name('all')).to match_array(Image.all)
      end

      it "should return all if params is ALl" do
        expect(Image.by_tag_name('ALl')).to match_array(Image.all)
      end

      it "should return all if params is a existing tag name" do
        tag = Tag.all.sample

        expect(Image.by_tag_name(tag.name)).to match_array(tag.images)
      end
    end
  end
end
