module FeatureMethods

  def register_user(updated_attributes = {})
    default_attributes = {
      :email => 'example@email.com',
      :password => 'password'
    }

    attributes = default_attributes.merge(updated_attributes)

    visit '/'
    click_link 'Sign Up'
    fill_in 'user[email]', with: attributes[:email]
    fill_in 'user[password]', with: attributes[:password]
    click_button 'Create User'
  end

  def login_user(updated_attributes = {})
    default_attributes = {
      :email => 'example@email.com',
      :password => 'password'
    }

    attributes = default_attributes.merge(updated_attributes)

    visit '/'
    fill_in 'email', with: attributes[:email]
    fill_in 'password', with: attributes[:password]
    click_button 'Login'
  end
end
