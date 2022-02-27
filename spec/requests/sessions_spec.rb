require 'rails_helper'

RSpec.describe "/users/sign_in", type: :request do
  
  describe 'POST #create' do
    context 'with correct credentials' do
      let(:password) { Faker::Internet.password }
      let(:user) { create(:user, password: password) }

      it 'login user' do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: password
          }
        }
        expect(response).to redirect_to(root_path) 
      end
    end

    context 'with wrong credentials' do
      let(:password) { Faker::Internet.password }
      let(:user) { create(:user, password: password) }

      it 'should not login user' do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: 'wrongpassword'
          }
        }
        expect(response).not_to redirect_to(root_path) 
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #new' do
    it 'show login page' do
      get new_user_session_path
      expect(response).to render_template(:new)
    end
  end
end