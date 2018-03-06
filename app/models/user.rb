class User < ActiveRecord::Base
    has_secure_password
    validates :username, :email, :password, presence: true 
    has_many :bookmarks
    has_many :tags, through: :bookmarks
end