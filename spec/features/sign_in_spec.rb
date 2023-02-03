require 'rails_helper'

RSpec.feature "SignIn", type: :feature do
  before do
    visit sign_in_path
  end

  let(:user) { User.create(username: "test", password: "password", password_confirmation: "password") }

  it "allows the user to create an account with valid credentials" do
    fill_in "Username", with: "test"
    fill_in "Password", with: "password"
    click_button "Sign In"

    expect(page).to have_content("Logged in successfully")
  end

  it "does not allow the user to create an account with invalid credentials" do    
    fill_in "Username", with: "test"
    fill_in "Password", with: "wrong_password"
    click_button "Sign In"

    expect(page).to have_content("Invalid username or password")
  end

  it "has links to sign up page" do
    expect(page).to have_link("Haven't created an account yet? Sign up here", href: sign_up_path)
  end
end