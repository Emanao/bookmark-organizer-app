class BookmarksController < ApplicationController
    get '/bookmarks' do
        if logged_in?
            @user=current_user
            @bookmarks=current_user.bookmarks
            @tags=current_user.tags
            erb :'bookmarks/index'
        else
            redirect "login"
        end
    end

end