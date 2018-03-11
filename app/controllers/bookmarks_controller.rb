class BookmarksController < ApplicationController
    #index
    get '/bookmarks' do
        if logged_in?
            @user=current_user      
            @bookmarks=current_user.bookmarks
            @tags=current_user.tags.distinct
            erb :'bookmarks/index'
        else
            redirect "login"
        end
    end
    #new
    get '/bookmarks/new' do
        if logged_in? 
            @tags = current_user.tags.distinct
            erb :'bookmarks/new'
        else
            redirect "login"
        end
    end
    post '/bookmarks' do
        if logged_in?
            bookmark = Bookmark.new(params[:bookmark])
            if !!bookmark
                bookmark.user=current_user
                #Check if user already has the new Tag. Show a warning if tag already exits
                #Dont run validations when bookmark is saved if field is empty
                if !params[:tag][:name].empty? 
                    existing_tag = current_user.tags.find_by(name: params[:tag][:name]) 
                    if !!existing_tag
                        flash[:existing_warning]='Tag name already exists, please check one of the existing ones'
                        redirect "bookmarks/new"
                    else
                        bookmark.tags.build(name: params[:tag][:name])
                    end
                end
                if !!bookmark.save            
                    redirect "bookmarks"
                else
                    flash[:warning]='Unable to create a new bookmark. Remember that the bookmark name cannot be blank.'
                    redirect "bookmarks/new"
                end
            else
                flash[:warning]='Unable to create a new bookmark.'
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
            @bookmark=current_user.bookmarks.find_by(id: params[:id])
            @tags=current_user.tags.distinct
            erb :"bookmarks/edit"
        else
            redirect "login"
        end
    end
    patch '/bookmarks/:id' do
        if logged_in?
            bookmark = current_user.bookmarks.find_by(id: params[:id])
            if !!bookmark
                #Bug fix for checkboxes: no tag_ids hash will be sendet if all checkboxes are unchecked. I need an empty array of ids in order to be able to update the tags. 
                params[:bookmark][:tag_ids]=[] if !params[:bookmark].include?(:tag_ids)
                bookmark.update(params[:bookmark])
                #Check if user already has the new Tag. Show a warning if tag already exits
                #Dont run validations when bookmark is saved if field is empty
                if !params[:tag][:name].empty? 
                    existing_tag = current_user.tags.find_by(name: params[:tag][:name]) 
                    if !!existing_tag
                        flash[:existing_warning]='Tag name already exists, please check one of the existing ones'
                        redirect "bookmarks/#{bookmark.id}/edit"
                    else
                        bookmark.tags.create(name: params[:tag][:name])
                    end
                end                
                if !!bookmark.valid?
                    redirect "bookmarks/#{bookmark.id}"
                else
                    flash[:warning]='Unable to edit this bookmark. Remember that the bookmark name can not be blank.'
                    redirect "bookmarks/#{bookmark.id}/edit"
                end
            else
                flash[:warning]='Unable to edit this bookmark.'
                redirect "bookmarks/#{bookmark.id}/edit"
            end
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