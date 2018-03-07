require './config/environment'

if ActiveRecord::Migrator.needs_migration?
    raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use ApplicationController
use BookmarksController
use SessionsController
use TagsController
use UsersController
run ApplicationController