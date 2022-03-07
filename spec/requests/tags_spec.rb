require 'rails_helper'

RSpec.describe "/tags", type: :request do
  let(:user) { create(:user) }

  before do
    login_as user
  end
  
  describe 'POST #create' do
    context 'with correct params' do
      it 'should create new tag' do
        expect {
          post tags_path, params: {
            tag: attributes_for(:tag)
          }
        }.to change(Tag, :count).by(1)
      end
    end

    context 'with duplicated name' do
      it 'should not create new tag' do
        tag = create(:tag, user_id: user.id)
        expect {
          post tags_path, params: {
            tag: { name: tag.name }
          }
        }.not_to change(Tag, :count)
      end
    end
  end

  describe 'GET #index' do
    it 'should show list of tags' do
      tags = create_list(:tag, 3, user_id: user.id)
      # we're using TagView instead of Tag
      tag_views = TagView.where(id: tags.map(&:id))
      get tags_path
      expect(assigns(:tags)).to match_array(tag_views)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'should filter list of tag by name' do
      tags = create_list(:tag, 3, user_id: user.id)
      target_tag = create(:tag, user_id: user.id)
      # we're using TagView instead of Tag
      tag_views = TagView.where(id: tags.map(&:id))
      target_tag_view = TagView.find(target_tag.id)
      get tags_path(name: target_tag.name)
      expect(assigns(:tags)).to match_array([target_tag_view])
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'should show an tag page' do
      tag = create(:tag, user_id: user.id)
      images1 = create_list(:image, 3, user_id: user.id)
      images2 = create_list(:image, 3, user_id: user.id)
      images2.each do |image|
        image.image_tags.create(tag_id: tag.id)
      end
      get tag_path(tag)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(assigns(:images)).to match_array(images2)
      expect(assigns(:images)).not_to match_array(images1)
    end
  end
end