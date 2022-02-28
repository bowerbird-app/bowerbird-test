require 'rails_helper'

RSpec.describe "Images", type: :request do
  describe "GET /images" do
    context 'unauthenticated' do
      it "returns status 302" do
        get images_path
        expect(response).to have_http_status(302)
        follow_redirect!

        expect(response).to render_template('devise/sessions/new')
      end
    end

    context 'authenticated' do
      let(:user) { FactoryBot.create(:user) }

      before do
        3.times { FactoryBot.create(:image, user: user) }
        3.times { FactoryBot.create(:image) }
        sign_in user
      end

      it "as an authenticated user returns status 200" do
        get images_path
        expect(response).to have_http_status(200)
        expect(response).to render_template('images/index')
        expect(assigns(:images)).to match_array(user.images)
      end
    end
  end

  describe "GET /images/{id}" do
    let(:image) { FactoryBot.create(:image) }

    context 'unauthenticated' do
      it "returns status 302" do
        get image_path(image)
        expect(response).to have_http_status(302)
        follow_redirect!

        expect(response).to render_template('devise/sessions/new')
      end
    end

    context 'authenticated' do
      before { sign_in image.user }

      it "as an authenticated user returns status 200" do
        get image_path(image)
        expect(response).to have_http_status(200)
        expect(response).to render_template('images/show')
        expect(assigns(:image)).to eq(image)
      end

      it "returns to root path if id does not exist" do
        get image_path(FactoryBot.create(:image))
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET /images/new" do
    context 'unauthenticated' do
      it "returns status 302" do
        get new_image_path
        expect(response).to have_http_status(302)
        follow_redirect!

        expect(response).to render_template('devise/sessions/new')
      end
    end

    context 'authenticated' do
      let(:user) { FactoryBot.create(:user) }

      before { sign_in user }

      it "as an authenticated user returns status 200" do
        get new_image_path
        expect(response).to have_http_status(200)
        expect(response).to render_template('images/new')
      end
    end
  end

  describe "POST /images" do
    let(:user) { FactoryBot.create(:user) }
    let(:image_params) { { image: FactoryBot.attributes_for(:image, user: nil) } }

    context 'unauthenticated' do
      it "returns status 302" do
        post images_path, params: image_params
        expect(response).to have_http_status(302)
        follow_redirect!

        expect(response).to render_template('devise/sessions/new')
      end
    end

    context 'authenticated' do
      before { sign_in user }

      it "as an authenticated user returns status 200" do
        post images_path, params: image_params
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(image_path(assigns[:image]))
      end
    end
  end

  describe "PUT /images/{id}" do
    let(:user) { FactoryBot.create(:user) }
    let(:image) { FactoryBot.create(:image, user: user) }
    let(:image_params) { { image: FactoryBot.attributes_for(:image, user: nil) } }

    context 'unauthenticated' do
      it "returns status 302" do
        put image_path(image), params: image_params
        expect(response).to have_http_status(302)
        follow_redirect!

        expect(response).to render_template('devise/sessions/new')
      end
    end

    context 'authenticated' do
      before { sign_in user }

      it "as an authenticated user returns status 200" do
        put image_path(image), params: image_params
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(image_path(assigns[:image]))
      end
    end
  end

  describe "DELETE /images/{id}" do
    let(:user) { FactoryBot.create(:user) }
    let(:image) { FactoryBot.create(:image, user: user) }

    context 'unauthenticated' do
      it "returns status 302" do
        delete image_path(image)
        expect(response).to have_http_status(302)
        follow_redirect!

        expect(response).to render_template('devise/sessions/new')
      end
    end

    context 'authenticated' do
      before { sign_in user }

      it "as an authenticated user returns status 200" do
        delete image_path(image)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(images_path)
      end

      it "returns to root path if id does not exist" do
        get image_path(FactoryBot.create(:image))
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
