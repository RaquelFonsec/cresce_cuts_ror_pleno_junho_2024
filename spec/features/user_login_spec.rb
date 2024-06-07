
require 'rails_helper'

RSpec.describe "User logging in", type: :feature do
  it "allows a user to log in" do
    user = User.create(email: "user@example.com", password: "password")

    visit new_user_session_path
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Log in"

    expect(page).to have_content "Signed in successfully."
  end
end
