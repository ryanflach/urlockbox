require 'rails_helper'

RSpec.feature 'Link status update' do

  before(:each) do
    @user = User.create!(email: 'hello@example.com', password: 'hello')
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(@user)
  end

  scenario 'they mark an unread link as read' do
    link = Link.create!(
      url: 'http://www.google.com',
      title: 'Google',
      user: @user
    )

    visit '/'

    within("#links ##{link.id}") { click_on 'Mark as Read' }

    within("#links ##{link.id}") do
      expect(page).to have_link('Mark as Unread')
    end
  end

  scenario 'they mark a read link as unread' do
    link = Link.create!(
      url: 'http://www.google.com',
      title: 'Google',
      user: @user,
      read: 'true'
    )

    visit '/'

    within("#links ##{link.id}") { click_on 'Mark as Unread' }

    within("#links ##{link.id}") do
      expect(page).to have_link('Mark as Read')
    end
  end
end
