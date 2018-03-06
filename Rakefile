ENV["SINATRA_ENV"] ||= "development"

require './config/environment'
require 'sinatra/activerecord/rake'

desc "MyConsole"
task :console do
    Pry.start
end

desc "Reseting the DB"
task :reset do
    User.destroy_all
    Bookmark.destroy_all
    BookmarkTag.destroy_all
    Tag.destroy_all
end