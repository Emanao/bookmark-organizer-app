class Bookmark < ActiveRecord::Base
    validates :name, presence: true
end