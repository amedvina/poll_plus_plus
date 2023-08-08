class User < ApplicationRecord
    has_secure_password
    has_many :polls
    has_many :posts, foreign_key: :author_id

    validates :username, presence: true
end
