class Album < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_rich_text :content
  has_one_attached :picture
end
