require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "GET /tags" do
    context 'unauthenticated' do
      it "returns status 302" do
        get tags_path
        expect(response).to have_http_status(302)
        follow_redirect!

        expect(response).to render_template('devise/sessions/new')
      end
    end

    context 'authenticated' do
      let(:user) { FactoryBot.create(:user) }

      before do
        tag = FactoryBot.create(:tag)
        3.times do
          image = FactoryBot.create(:image, user: user)
          FactoryBot.create(:image_tag, tag: tag, image: image)
        end

        sign_in user
      end

      it "as an authenticated user returns status 200" do
        get tags_path
        expect(response).to have_http_status(200)
        expect(response).to render_template('tags/index')
        expect(assigns(:tags)).to match_array(user.tags.uniq)
      end
    end
  end

  describe "GET /tags/{id}" do
    let(:image) { FactoryBot.create(:image) }
    let(:tag) do
      tag = FactoryBot.create(:tag)
      FactoryBot.create(:image_tag, tag: tag, image: image)

      tag
    end

    context 'unauthenticated' do
      it "returns status 302" do
        get tag_path(tag)
        expect(response).to have_http_status(302)
        follow_redirect!

        expect(response).to render_template('devise/sessions/new')
      end
    end

    context 'authenticated' do
      before { sign_in image.user }

      it "as an authenticated user returns status 200" do
        get tag_path(tag)
        expect(response).to have_http_status(200)
        expect(response).to render_template('tags/show')
        expect(assigns(:tag)).to eq(tag)
      end

      it "returns to root path if id does not exist" do
        get tag_path(FactoryBot.create(:tag))
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
