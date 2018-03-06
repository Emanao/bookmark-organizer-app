class BookmarksController < ApplicationController
    get '/bookmarks' do
        @bookmarks=Bookmark.all.last
        erb :'bookmarks/index'
    end

end