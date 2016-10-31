class Link < ApplicationRecord
  validates :url, presence: true, url: true
  validates :title, presence: true
  enum read: [:false, :true]
  belongs_to :user
end
