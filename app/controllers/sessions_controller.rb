class SessionsController < ApplicationController
    get '/login' do
        if logged_in?
            redirect :"bookmarks"
        else
            redirect :"users/login"
        end
    end
    post '/login' do
        user = User.find_by(username: params[:username])
        if !!user && user.authenticate(params[:password])
            session[:user_id]=user.id
            redirect "bookmarks"
        else
            flash[:warning]="Unable to log in. Remember that all field are required. Please try again"
            redirect "login"
        end
    end
    get '/logout' do
        session.clear
        redirect "login"
    end
  
end