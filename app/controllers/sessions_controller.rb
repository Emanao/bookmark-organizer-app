class SessionsController < ApplicationController
    get '/login' do
        erb :"users/login"
    end
    post '/login' do
        "I got you 1!"
    end
  
end