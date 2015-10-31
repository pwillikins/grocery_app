require 'spec_helper'

feature "Login" do
  scenario "user can login and logout" do
    register_user
    expect(page).to have_link 'Logout'

    click_link 'Logout'

    click_link'Login'
    login_user
    expect(page).to have_link 'Logout'
    click_link 'Logout'
    expect(page).to have_content "You have logged out"
  end
end