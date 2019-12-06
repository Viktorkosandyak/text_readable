class Post < ApplicationRecord
  belongs_to :user
  validates :content, length: { minimum: 5 }
  default_scope { order(index_readability: :desc)}
end