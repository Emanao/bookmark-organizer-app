class TagsController < ApplicationController
    get '/tags' do
        redirect "bookmarks"
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
            binding.pry
            tag = current_user.tags.find_by(id: params[:id])
            tag.update(params[:tag])
            if !!tag.valid?
                redirect "tags/#{tag.id}"
            else
                flash[:warning]='Unable to edit this tag. Remember that the tag name can not be blank. Please try again '
                redirect "tags/#{params[:id]}/edit"
            end

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