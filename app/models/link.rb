class Link < ApplicationRecord
  validates :url, presence: true, url: true
  validates :title, presence: true
  enum read: [:false, :true]
  belongs_to :user

  def opposite_read_value
    read == 'true' ? 'false' : 'true'
  end
end
