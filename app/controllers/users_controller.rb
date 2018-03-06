class UsersController < ApplicationController
    get '/signup' do
       erb :"users/signup"
    end
    post '/signup' do
        if !!User.find_by(username: params[:username])
            flash[:warning]=" Username already exits. Try again or login in your account"
            redirect "signup"
        else
            user=User.new(username: params[:username], email: params[:email])
            user.password = params[:password]
            if !!user && user.save
                session[:id]=user.id
                redirect "bookmarks"
            else
                flash[:warning]="Unable to create a new account. Please try again"
                redirect "signup"
            end


        end
    end

end