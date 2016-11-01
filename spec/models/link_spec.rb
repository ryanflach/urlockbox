require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should validate_presence_of :url }
  it { should validate_presence_of :title }
  it { should have_db_column(:read).with_options(default: 'false') }
  it { should belong_to :user }

  it 'should not allow invalid URLs' do
    user = User.create!(email: 'hi@hi.com', password: 'pass')
    link = Link.new(url: 'invalid', title: 'not allowed', user: user)
    expect(link.save).to eq(false)
  end

  it 'should filter by read links' do
    user = User.create!(email: 'hi@hi.com', password: 'pass')
    read = Link.create!(
      url: 'http://www.google.com',
      title: 'not allowed',
      user: user,
      read: 'true')
    unread = Link.create!(
      url: 'http://www.bing.com',
      title: 'not allowed',
      user: user
    )
    expect(Link.read.count).to eq(1)
    expect(Link.read.first).to eq(read)
  end
  
  it 'should filter by unread links' do
    user = User.create!(email: 'hi@hi.com', password: 'pass')
    read = Link.create!(
      url: 'http://www.google.com',
      title: 'not allowed',
      user: user,
      read: 'true')
    unread = Link.create!(
      url: 'http://www.bing.com',
      title: 'not allowed',
      user: user
    )
    expect(Link.unread.count).to eq(1)
    expect(Link.unread.first).to eq(unread)
  end
end
