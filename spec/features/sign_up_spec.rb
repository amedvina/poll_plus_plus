require "rails_helper"

RSpec.feature "Sign up", type: :feature do
  before do
    visit sign_up_path
  end

  it "allows user to sign in with correct credentials" do
    fill_in "Username", with: "test"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign Up"
    
    expect(page).to have_text("Successfully created account")
  end

  it "does allow user to sign in with correct credentials" do
    fill_in "Username", with: "test"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "pass"
    click_button "Sign Up"

    expect(page).to have_text("Password confirmation doesn't match Password")
  end

  it "has links to sign in page" do
    expect(page).to have_link("Have an account? Sign in here", href: sign_in_path)
  end
end