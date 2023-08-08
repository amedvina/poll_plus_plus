class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  validates :title, presence: true
  validates :content, presence: true
end
