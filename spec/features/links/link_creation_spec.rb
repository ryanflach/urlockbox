require 'rails_helper'

RSpec.feature 'Link creation' do

  before(:each) do
    user = User.create!(email: 'hello@example.com', password: 'hello')
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)
  end

  context 'authenticated user' do
    context 'valid parameters' do
      scenario 'they visit the root path' do
        expect(Link.count).to eq(0)

        visit '/'

        within('#link-form') do
          fill_in 'URL', with: 'http://www.google.com'
          fill_in 'Title', with: 'Google'
          click_on 'Submit'
        end

        expect(page).to have_content("Link to Google successfully added.")
        expect(Link.count).to eq(1)
        within('#links') do
          expect(page).to have_link('http://www.google.com')
        end
      end
    end

    context 'invalid parameters' do
      scenario 'with invalid URL' do
        visit '/'

        within('#link-form') do
          fill_in 'URL', with: 'not_a_url'
          fill_in 'Title', with: 'Google'
          click_on 'Submit'
        end

        expect(Link.count).to eq(0)
        expect(page).to have_content('Url is not a valid URL')
      end

      scenario 'with missing Title' do
        visit '/'

        within('#link-form') do
          fill_in 'URL', with: 'http://www.google.com'
          click_on 'Submit'
        end

        expect(Link.count).to eq(0)
        expect(page).to have_content("Title can't be blank")
      end
    end
  end
end
