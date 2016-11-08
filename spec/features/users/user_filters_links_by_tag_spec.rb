require 'rails_helper'

RSpec.feature 'User filters links by tag' do

  before(:each) do
    user = User.create!(email: 'hello@example.com', password: 'pass')

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)

    tag_1 = Tag.create!(name: 'hello')
    tag_2 = Tag.create!(name: 'fun')

    @google_link = user.links.create!(
      title: 'Google',
      url: 'http://www.google.com',
      tags: [tag_1]
    )

    @hi_link = user.links.create!(
      title: 'Hi',
      url: 'http://www.hi.com',
      tags: [tag_2]
    )

    @no_tags_link = user.links.create!(
      title: 'No Tags',
      url: 'http://www.notags.com'
    )
  end

  context 'authorized user with tagged links', js: true do
    scenario 'they filter by a tag' do
      visit links_path

      within('#links') do
        click_on 'hello'
      end

      within('#links') do
        expect(page).to have_content(@google_link.title)
        expect(page).to_not have_content(@no_tags_link.title)
        expect(page).to_not have_content(@hi_link.title)
      end

      click_on 'Show All'

      within('#links') do
        click_on 'fun'
      end

      within('#links') do
        expect(page).to_not have_content(@google_link.title)
        expect(page).to_not have_content(@no_tags_link.title)
        expect(page).to have_content(@hi_link.title)
      end
    end
  end
end
