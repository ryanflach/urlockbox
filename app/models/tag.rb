class Tag < ApplicationRecord
  has_many :link_tags
  has_many :links, through: :link_tags
end
