require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should validate_presence_of :url }
  it { should validate_presence_of :title }
  it { should have_db_column(:read).with_options(default: 'false') }
  it { should belong_to :user }
  it 'should not allow invalid URLs' do
    link = Link.new(url: 'invalid')
    expect(link.save).to eq(false)
  end
end
