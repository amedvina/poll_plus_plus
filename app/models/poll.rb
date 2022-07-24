class Poll < ApplicationRecord
  has_many :candidates, dependent: :destroy

  validates :title, presence: true
end
