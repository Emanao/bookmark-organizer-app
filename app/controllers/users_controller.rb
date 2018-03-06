class UsersController < ApplicationController
    get '/signup' do
       erb :"users/signup"
    end
    post '/signup' do
        if !!User.find_by(username: params[:username])
            #username already exits either try again or login in your account
        else
            user=User.new(username: params[:username], email: params[:email])
            user.password = params[:password]
            if !!user && user.save
                session[:id]=user.id
                redirect "bookmarks"
            else
            end


        end
    end

end