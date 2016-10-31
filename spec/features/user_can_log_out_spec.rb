require 'rails_helper'

RSpec.feature 'User can log out' do
  context 'logged in user' do
    scenario 'they log out from the root path' do
      user = User.create!(email: 'hello@example.com', password: 'hello')

      visit '/'

      within('#login-form') do
        fill_in 'E-mail', with: user.email
        fill_in 'Password', with: 'hello'
        fill_in 'Verify Password', with: 'hello'
        click_on 'Login'
      end

      click_on "Sign Out"

      expect(current_path).to eq(login_path)
      expect(page).to have_button("Login")
      expect(page).to_not have_link("Sign Out")

    end
  end
end
