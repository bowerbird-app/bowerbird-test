require "rails_helper"

RSpec.describe "Session System Test", type: :system do
  let(:password) { Faker::Internet.password }
  let(:user) { create(:user, password: password) }

  it "login as an user" do
    visit new_user_session_path
    # should see login form
    expect(page).to have_content("Sign in to BowerBird")
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_on("Sign in")
    # success login should redirect to root
    expect(page).to have_current_path(root_path)
  end

  it "login with wrong password" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: 'wrongpassword'
    click_on("Sign in")
    # success login should redirect to root
    expect(page).to have_content("Invalid Email or password.")
  end

  it "login with wrong password" do
    visit new_user_session_path
    fill_in "Email", with: Faker::Internet.unique.email
    fill_in "Password", with: password
    click_on("Sign in")
    # success login should redirect to root
    expect(page).to have_content("Invalid Email or password.")
  end

end