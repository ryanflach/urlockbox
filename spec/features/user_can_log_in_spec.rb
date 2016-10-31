require 'rails_helper'

RSpec.feature 'User can log in' do
  context 'Unauthenticated user' do
    scenario 'they are redirected to login when visiting the root' do
      visit '/'

      expect(current_path).to eq('/login')
      within('#login-form') do
        expect(page).to have_field('E-mail')
        expect(page).to have_field('Password')
        expect(page).to have_field('Verify Password')
        expect(page).to have_button('Login')
      end
      expect(page).to have_link('Sign Up')
    end

    scenario 'they create an account with valid information' do
      visit '/'
      click_on 'Sign Up'

      expect(current_path).to eq(new_user_path)

      within('#login-form') do
        fill_in 'E-mail', with: 'user@example.com'
        fill_in 'Password', with: 'pass'
        fill_in 'Verify Password', with: 'pass'
        click_on 'Sign Up'
      end

      expect(current_path).to eq(links_path)
      expect(page).to have_content('Welcome, user@example.com!')
    end

    scenario 'they create an account with invalid information' do
      visit new_user_path

      within('#login-form') do
        fill_in 'E-mail', with: 'user@example.com'
        fill_in 'Password', with: 'pass'
        fill_in 'Verify Password', with: 'mismatched pass'
        click_on 'Sign Up'
      end

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content('Passwords must match. Please try again.')
    end
  end
end
