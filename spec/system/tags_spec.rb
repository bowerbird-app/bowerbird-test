require "rails_helper"

RSpec.describe "Tags System Test", type: :system do
  before do 
    login_as create(:user)
  end
  
  it "should show list of tags" do
    tags = create_list(:tag, 3)
    visit tags_path
    expect(page).to have_current_path(tags_path)
    expect(page).to have_content("Tags")
    tags.each do |tag|
      expect(page).to have_content(tag.name)
    end
  end

  it "should show tag page" do
    tag = create(:tag)
    images = create_list(:image, 3)
    images.each do |image|
      image.image_tags.create(tag_id: tag.id)
    end
    visit tag_path(tag)
    expect(page).to have_current_path(tag_path(tag))
    expect(page).to have_content(tag.name)
    images.each do |image|
      expect(page).to have_content(image.name)
    end
  end

  it "should create a tag" do
    tag_attributes = attributes_for(:tag)
    visit tags_path
    click_on(class: "new-tag-button")
    fill_in "tag[name]", with: tag_attributes[:name]
    click_on("Create")
    expect(page).to have_content(tag_attributes[:name])
  end

end