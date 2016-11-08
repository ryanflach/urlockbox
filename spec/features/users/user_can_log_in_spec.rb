require 'rails_helper'

RSpec.feature 'User can log in' do
  context 'Unauthenticated user' do
    scenario 'they are redirected to login when visiting the root' do
      visit '/'

      expect(current_path).to eq('/login')
      within('#login-form') do
        expect(page).to have_field('E-mail')
        expect(page).to have_field('Password')
        expect(page).to_not have_field('Verify Password')
        expect(page).to have_button('Login')
      end
      expect(page).to have_link('Sign Up')
    end
  end

  context 'Existing user' do
    scenario 'they are redirected to the links path when logged in' do
      user = User.create!(email: 'hello@example.com', password: 'hello')

      visit '/'

      within('#login-form') do
        fill_in 'E-mail', with: user.email
        fill_in 'Password', with: 'hello'
        click_on 'Login'
      end

      expect(current_path).to eq(links_path)
      expect(page).to have_content("Successfully logged in. Welcome, #{user.email}!")
    end
  end
end
