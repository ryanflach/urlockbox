require 'rails_helper'

RSpec.describe 'Link deletion' do
  before(:each) do
    user = User.create!(email: 'hello@example.com', password: 'pass')
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)
    tag = Tag.create!(name: 'hello')
    @link = user.links.create!(
      title: 'Google',
      url: 'http://www.google.com',
      tags: [tag]
    )
  end

  context 'authorized user with links' do
    scenario 'they delete a link from the links page', js: true do
      visit links_path

      click_on 'Delete'

      expect(Tag.count).to eq(1)
      expect(page).to_not have_content('Google')
      expect(page).to_not have_content('http://www.google.com')
      expect(Link.count).to eq(0)
    end
  end
end
