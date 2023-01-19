class Poll < ApplicationRecord
  has_many :candidates, dependent: :destroy
  accepts_nested_attributes_for :candidates
  belongs_to :author, class_name: "User", foreign_key: 'author'

  validates :title, presence: true
end
