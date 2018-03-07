class BookmarksController < ApplicationController
    #index
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
    #new
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
            bookmark.tags.build(params[:tag]) if !params[:tag][:name].empty?
            
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
    #show
    get '/bookmarks/:id' do
        if logged_in?
            @bookmark = current_user.bookmarks.find_by(id: params[:id])
            erb :"bookmarks/show"
        else
            redirect "login"
        end

    end
    # edit
    get '/bookmarks/:id/edit' do
        if logged_in?
            erb :"bookmarks/edit"
        else
            redirect "login"
        end
    end
    patch '/bookmarks/:id' do
        if logged_in?
            @bookmark = current_user.bookmarks.find_by(id: params[:id])
            redirect "bookmarks/show"
        else
            redirect "login"
        end
    end
    #delete
    delete '/bookmarks/:id/delete' do
        if logged_in?
            bookmark = current_user.bookmarks.find_by(id: params[:id])
            bookmark.destroy if !!bookmark
            redirect "bookmarks"
        else
            redirect "login"
        end

        
    end

end