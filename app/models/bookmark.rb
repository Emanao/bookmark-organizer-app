class Bookmark < ActiveRecord::Base
    validates :name, presence: true
    belongs_to :user
    has_many :bookmark_tags
    has_many :tags, through: :bookmark_tags
end