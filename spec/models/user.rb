require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensure email presence' do
      user = User.new attributes_for(:user, email: nil)
      expect(user.save).to eq(false)
    end

    it 'ensure password presence' do
      user = User.new attributes_for(:user, password: nil)
      expect(user.save).to eq(false)
    end

    it 'ensure email format valid' do
      user = User.new attributes_for(:user, email: 'not_an_email_address.com')
      expect(user.save).to eq(false)
    end

    it 'ensure password more than 6 characters' do
      user = User.new attributes_for(:user, password: '12345')
      expect(user.save).to eq(false)
    end
  end

  context 'association test' do
    it { should have_many(:images) }
    it { should have_many(:tags) }
    it { should have_many(:tag_views) }
  end
end
