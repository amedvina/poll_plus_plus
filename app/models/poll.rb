class Poll < ApplicationRecord
  has_many :candidates, dependent: :destroy
  accepts_nested_attributes_for :candidates
  belongs_to :author, class_name: "User"

  validates :title, presence: true
  validates :author_id, presence: true
end
