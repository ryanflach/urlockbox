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
        expect(page).to have_button('Sign Up')
      end
    end
  end
end
