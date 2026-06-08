require 'sinatra'
require 'redcarpet'

APP_ROOT = File.expand_path(__dir__)

configure do
    set :bind, '0.0.0.0'
    set :port, 9394
    set :public_folder, File.expand_path('../public', __dir__)
    set :environment, :production
    disable :protection
end

require_relative '../app/routes/system'