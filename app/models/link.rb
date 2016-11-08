class Link < ApplicationRecord
  validates :url, presence: true, url: true
  validates :title, presence: true
  enum read: [:false, :true]
  belongs_to :user
  has_many :link_tags, dependent: :destroy
  has_many :tags, through: :link_tags

  def opposite_read_value
    read == 'true' ? 'false' : 'true'
  end

  def tag_names
    tags.pluck(:name).join(' ')
  end
end
