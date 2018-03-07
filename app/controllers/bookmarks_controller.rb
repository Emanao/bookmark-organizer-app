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
    get '/bookmarks/new' do
        if logged_in?
            @tags = Tag.all
            erb :'bookmarks/new'
        else
            redirect "login"
        end
    end
    post '/bookmarks' do
        if logged_in?

            bookmark = Bookmark.new(params[:bookmark])
            bookmark.user=current_user
            bookmark.tags.build(name: params[:tag][:name])
            if !!bookmark.save             
                redirect "bookmarks"
            else
                flash[:warning]='Unable to create a new bookmark. Remember that the name is required. Please try again '
                redirect "bookmarks/new"
            end
            
        else
            redirect "login"
        end

    end

end