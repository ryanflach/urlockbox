require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should validate_presence_of :url }
  it { should validate_presence_of :title }
  it { should have_db_column(:read).with_options(default: 'false') }
  it { should belong_to :user }
  it { should have_many(:link_tags).dependent(:destroy) }
  it { should have_many(:tags).through(:link_tags) }

  it 'should not allow invalid URLs' do
    user = User.create!(email: 'hi@hi.com', password: 'pass')
    link = Link.new(url: 'invalid', title: 'not allowed', user: user)
    expect(link.save).to eq(false)
  end

  it 'should provide a string of comma-separated tag names' do
    user = User.create!(email: 'hi@hi.com', password: 'pass')
    tag_1 = Tag.create!(name: 'hello')
    tag_2 = Tag.create!(name: 'great')
    link = Link.create!(
      url: 'http://www.google.com',
      title: 'Google',
      user: user,
      tags: [tag_1, tag_2]
    )
    expect(link.tag_names).to eq('hello, great')
  end
end
