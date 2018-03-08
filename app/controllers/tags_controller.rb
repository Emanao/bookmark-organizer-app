class TagsController < ApplicationController
    get '/tags' do
        "Welcome to the Bookmark Organizer - Tags index" 
    end
    #show
    get '/tags/:id' do
        @tag=current_user.tags.find_by(id: params[:id])
        erb :'tags/show'
    end

end