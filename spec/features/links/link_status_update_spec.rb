require 'rails_helper'

RSpec.feature 'Link status update' do

  before(:each) do
    @user = User.create!(email: 'hello@example.com', password: 'hello')
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(@user)
  end

  scenario 'they mark an unread link as read', js: true do
    link = Link.create!(
      url: 'http://www.google.com',
      title: 'Google',
      user: @user
    )

    visit '/'

    click_on 'Mark as Read'

    expect(page).to have_link('Mark as Unread')
    expect(page).to_not have_link('Mark as Read')
  end

  scenario 'they mark a read link as unread', js: true do
    link = Link.create!(
      url: 'http://www.google.com',
      title: 'Google',
      user: @user,
      read: 'true'
    )

    visit '/'

    click_on 'Mark as Unread'

    expect(page).to have_link('Mark as Read')
    expect(page).to_not have_link('Mark as Unread')
  end
end
