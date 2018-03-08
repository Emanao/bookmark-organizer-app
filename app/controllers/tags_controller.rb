class TagsController < ApplicationController
    get '/tags' do
        "Welcome to the Bookmark Organizer - Tags index" 
    end
    #show
    get '/tags/:id' do
        if logged_in? 
            @tag=current_user.tags.find_by(id: params[:id])
            erb :'tags/show'
        else
            redirect "login"
        end

    end
    #edit
    get '/tags/:id/edit' do
        if logged_in? 
            @tag=current_user.tags.find_by(id: params[:id])
            erb :'tags/edit'
        else
            redirect "login"
        end

    end
    patch '/tags/:id' do 
        if logged_in? 

        else
            redirect "login"
        end
    end
    #delete action
    delete '/tags/:id/delete' do
        if logged_in?
            tag = current_user.tags.find_by(id: params[:id])
            tag.destroy if !!tag
            redirect "bookmarks"
        else
            redirect "login"
        end
    end

end