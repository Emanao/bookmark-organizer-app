class ApplicationController < Sinatra::Base
    register Sinatra::Flash
    configure do
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "bookmark_secret_key"
      end
    
    get "/" do
        erb :index
    end

    helpers do
        def logged_in?
            !!current_user
        end
        def current_user
            @current_user ||= User.find_by(id: session[:user_id]) if !!session[:user_id]
        end
    end
end