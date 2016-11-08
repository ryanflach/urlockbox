require 'rails_helper'

RSpec.feature 'User searches for links' do

  before(:each) do
    user = User.create!(email: 'hello@example.com', password: 'pass')
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)
    tag = Tag.create!(name: 'search')
    user.links.create!(
      title: 'Google',
      url: 'http://www.google.com',
      tags: [tag]
    )
    user.links.create!(
      title: 'Bing',
      url: 'http://www.bing.com',
      tags: [tag]
    )
  end

  context 'authorized user with links' do
    scenario 'they search for a link by name', js: true do
      visit '/'

      fill_in 'search-box', with: 'google'

      within('#links') do
        expect(page).to have_content('Google')
        expect(page).to_not have_content('Bing')
      end
    end

    scenario 'they search for a link by URL', js: true do
      visit '/'

      fill_in 'search-box', with: 'bing.com'

      within('#links') do
        expect(page).to_not have_content('Google')
        expect(page).to have_content('Bing')
      end
    end

    scenario 'they search for a link by tag name', js: true do
      visit '/'

      fill_in 'search-box', with: 'search'

      within('#links') do
        expect(page).to have_content('Google')
        expect(page).to have_content('Bing')
      end
    end
  end
end
