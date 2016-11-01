require 'rails_helper'

RSpec.feature 'User filters links' do

  before(:each) do
    user = User.create!(email: 'hello@example.com', password: 'pass')
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)
    user.links.create!(title: 'Google', url: 'http://www.google.com')
    user.links.create!(
      title: 'Hi',
      url: 'http://www.hi.com',
      read: 'true'
    )
  end

  context 'authorized user with read and unread links', js: true do
    scenario 'they filter by read links' do
      visit '/'

      click_on 'Filter Read'

      within('#links') do
        expect(page).to have_content('Hi')
        expect(page).to have_link('http://www.hi.com')
        expect(page).to_not have_content('Google')
        expect(page).to_not have_link('http://www.google.com')
      end
    end

    scenario 'they filter by unread links' do
      visit '/'

      click_on 'Filter Unread'

      within('#links') do
        expect(page).to have_content('Hi')
        expect(page).to have_link('http://www.hi.com')
        expect(page).to_not have_content('Google')
        expect(page).to_not have_link('http://www.google.com')
      end
    end
  end
end
