require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_many(:links).through(:link_tags) }
  it { should have_many(:link_tags) }
end
