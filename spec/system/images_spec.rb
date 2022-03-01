require "rails_helper"

RSpec.describe "Images System Test", type: :system do
  before do 
    login_as create(:user)
  end
  
  
  it "should show list of images" do
    images = create_list(:image, 3)
    visit root_path
    # should be able to visit root_path if logged in
    expect(page).to have_current_path(root_path)
    expect(page).to have_content("Images")
    images.each do |image|
      expect(page).to have_content(image.name)
    end
  end

  it "should show image page" do
    image = create(:image)
    # can't use image_path because it's referenced to the screenshot
    visit image_url(image)
    expect(page).to have_current_path("/images/#{image.id}")
    expect(page).to have_content(image.name)
  end

  it "should create an image" do
    image_attributes = attributes_for(:image)
    visit root_path
    click_on(class: "new-image-button")
    fill_in "image[name]", with: image_attributes[:name]
    attach_file "image[file]", Rails.root + "spec/fixtures/glass-building.jpeg"
    click_on("Upload")
    expect(page).to have_content(image_attributes[:name])
  end

  it "should delete image from index page" do
    # rack_test doesn't support click on alert box
    driven_by(:selenium)
    image = create(:image)
    visit root_path
    click_on("Action")
    click_on("Delete")
    page.driver.browser.switch_to.alert.accept
    visit root_path
    expect(page).not_to have_content(image.name)
  end

  it "should delete image from show page" do
    # rack_test doesn't support click on alert box
    driven_by(:selenium)
    image = create(:image)
    # for some reasons capybara get stucked whenever it is
    # trying to visit image_url(image)
    # possibly because it's referencing to selenium driver method?
    visit "/images/#{image.id}"
    click_on("Delete")
    page.driver.browser.switch_to.alert.accept
    # redirect to images_path after delete
    expect(page).to have_current_path(images_path)
    expect(page).not_to have_content(image.name)
  end

end