require 'rails_helper'

RSpec.describe "/images", type: :request do

  before do
    login_as create(:user)
  end
  
  describe 'POST #create' do
    context 'with correct params' do
      it 'should create new images' do
        expect {
          post images_path, params: {
            image: attributes_for(:image, :from_fixture)
          }
        }.to change(Image, :count).by(1)
      end
    end

    context 'with missing params' do
      it 'should not create new images' do
        expect {
          post images_path, params: {
            image: attributes_for(:image, :from_fixture).except(:name)
          }
        }.not_to change(Image, :count)
      end
    end
  end

  describe 'GET #index' do
    it 'should show list of images' do
      images = create_list(:image, 3)
      get images_path
      expect(assigns(:images)).to match_array(images)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'should filter list of images by name' do
      images = create_list(:image, 3)
      target_image = create(:image)
      get images_path(name: target_image.name)
      expect(assigns(:images)).to match_array([target_image])
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'should filter list of images by tag_id' do
      # setting up 2 images with different tag_id
      tag1 = create(:tag)
      tag2 = create(:tag)
      image1 = create(:image)
      image2 = create(:image)
      image1.image_tags.create(tag_id: tag1.id)
      image2.image_tags.create(tag_id: tag2.id)

      get images_path(tag_id: tag1.id)
      expect(assigns(:images)).to match_array([image1])
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'should filter list of images by name and tag_id' do
      # setting up 3 images with same name and 2 different tag_id
      name = Faker::Lorem.words(number: 4).join(' ')
      tag1 = create(:tag)
      tag2 = create(:tag)
      image1 = create(:image, name: name)
      image2 = create(:image, name: name)
      image3 = create(:image, name: name)
      image1.image_tags.create(tag_id: tag1.id)
      image2.image_tags.create(tag_id: tag2.id)
      image3.image_tags.create(tag_id: tag2.id)

      get images_path(name: name, tag_id: tag2.id)
      expect(assigns(:images)).to match_array([image2, image3])
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'should show an image page' do
      image = create(:image)
      get image_path(image)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete image' do
      image = create(:image)
      expect {
        delete image_path(image)
      }.to change(Image, :count).by(-1)
    end
  end
end