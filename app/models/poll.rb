class Poll < ApplicationRecord
  has_many :candidates, dependent: :destroy
  accepts_nested_attributes_for :candidates

  validates :title, presence: true
end
