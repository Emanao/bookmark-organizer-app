class ApplicationController < Sinatra::Base
    register Sinatra::Flash
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "bookmark_secret_key"
      end
    
    get "/" do
        erb :index
    end
end