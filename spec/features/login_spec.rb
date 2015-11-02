require 'spec_helper'

describe "the signin process", :type => :feature do
  before :each do
    # User.create(:email => 'user@example.com', :password => 'password')
    register_user
  end

  it "logs a user in" do
    visit '/'
    click_link 'Sign Up'
    fill_in 'email', with: 'user@example.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
    expect(page).to have_link 'Logout'
  end

end


# feature "Login" do
#   scenario "user can login and logout" do
#     register_user
#     expect(page).to have_link 'Logout'
#
#     click_link 'Logout'
#
#     click_link'Login'
#     login_user
#     expect(page).to have_link 'Logout'
#     click_link 'Logout'
#     expect(page).to have_content "You have logged out"
#   end
# end