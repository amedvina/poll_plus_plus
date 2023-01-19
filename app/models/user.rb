class User < ApplicationRecord
    has_secure_password
    has_many :polls

    validates :username, presence: true
end
