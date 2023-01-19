require "rails_helper"

RSpec.feature "Sign up", type: :feature do
  scenario "User signs up with valid information" do
    visit sign_up_path
    fill_in "Username", with: "test"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign Up"
    expect(page).to have_text("Successfully created account")
  end

  scenario "User signs up with invalid information" do
    visit sign_up_path
    fill_in "Username", with: "test"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "pass"
    click_button "Sign Up"
    expect(page).to have_text("Password confirmation doesn't match Password")
  end
end