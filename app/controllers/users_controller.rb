class UsersController < ApplicationController
    get '/signup' do
        if logged_in? 
            redirect :'bookmarks' 
        else
            erb :'users/signup', :layout=> :home_layout
        end
    end
    post '/signup' do
        if !!User.find_by(username: params[:username])
            flash[:warning]=" Username already exits. Try again or login in your account"
            redirect "signup"
        else
            user=User.new(username: params[:username], email: params[:email])
            user.password = params[:password]
            if !!user && user.save
                session[:user_id]=user.id
                redirect "bookmarks"
            else
                flash[:warning]="Unable to sign you up. Remember that all fields are required. Please try again"
                redirect "signup"
            end


        end
    end

end