class Album < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_rich_text :content
end
