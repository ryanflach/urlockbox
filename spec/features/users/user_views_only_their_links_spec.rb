require 'rails_helper'

RSpec.feature 'User views only their links' do

  before(:each) do
    user = User.create!(email: 'hello@example.com', password: 'pass')
    other_user = User.create!(email: 'hi@hello.com', password: 'pass')
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)
    user.links.create!(title: 'Google', url: 'http://www.google.com')
    @alt_link = other_user.links.create!(
      title: 'Bing',
      url: 'http://www.bing.com'
    )
    @link = user.links.first
  end

  context 'authorized user with links' do
    scenario 'they visit the links path' do
      visit links_path

      within('#links') do
        expect(page).to have_content(@link.title)
        expect(page).to have_link(@link.url)
        expect(page).to_not have_content(@alt_link.title)
        expect(page).to_not have_link(@alt_link.url)
      end
    end
  end
end
