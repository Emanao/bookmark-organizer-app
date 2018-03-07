class Tag < ActiveRecord::Base
    #validates :name, presence: true
    has_many :bookmark_tags
    has_many :bookmarks, through: :bookmark_tags
end