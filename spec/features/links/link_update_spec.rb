require 'rails_helper'

RSpec.feature 'Link update' do

  before(:each) do
    user = User.create!(email: 'hello@example.com', password: 'pass')
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)
    user.links.create!(title: 'Google', url: 'http://www.google.com')
    @link = user.links.first
  end

  context 'authorized user with links' do
    context 'with valid parameters' do
      scenario 'they update a link title' do
        visit '/'

        within("#links ##{@link.id}") do
          click_on 'Edit'
        end

        expect(current_path).to eq(edit_link_path(@link))

        fill_in 'Title', with: 'SUPER GOOGLE'
        click_on 'Update'

        expect(current_path).to eq(links_path)
        within("#links ##{@link.id}") do
          expect(page).to have_content('SUPER GOOGLE')
          expect(page).to_not have_content('Google')
          expect(page).to have_link('http://www.google.com')
        end
      end

      scenario 'they update a link URL' do

      end

      scenario 'they update a link title and URL' do
        
      end
    end

    context 'with invalid parameters' do
      scenario 'with invalid URL' do

      end
    end
  end
end
