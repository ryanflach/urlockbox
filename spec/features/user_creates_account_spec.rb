require 'rails_helper'

RSpec.feature 'User creates an account' do
  context 'with valid parameters' do
    scenario 'they create an account' do
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
      expect(page).to have_content("Account created. Welcome, user@example.com!")
    end
  end

  context 'with invalid parameters' do
    scenario 'with mismatched password' do
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

    scenario 'with missing username' do
      visit new_user_path

      within('#login-form') do
        fill_in 'Password', with: 'pass'
        fill_in 'Verify Password', with: 'pass'
        click_on 'Sign Up'
      end

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Email can't be blank")
    end

    scenario 'with taken username' do
      User.create!(email: 'taken@example.com', password: 'hello')

      visit new_user_path

      within('#login-form') do
        fill_in 'E-mail', with: 'taken@example.com'
        fill_in 'Password', with: 'pass'
        fill_in 'Verify Password', with: 'pass'
        click_on 'Sign Up'
      end

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content('Email has already been taken')
    end
  end
end
