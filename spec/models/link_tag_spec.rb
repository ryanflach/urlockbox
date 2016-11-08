require 'rails_helper'

RSpec.describe LinkTag, type: :model do
  it { should belong_to(:link) }
  it { should belong_to(:tag) }
end
