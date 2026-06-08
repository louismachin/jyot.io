require 'sinatra'
require 'redcarpet'
require 'securerandom'

APP_ROOT = File.expand_path(__dir__)

configure do
    set :bind, '0.0.0.0'
    set :port, 9394
    set :views, File.expand_path('../app/views', __dir__)
    set :public_folder, File.expand_path('../public', __dir__)
    set :environment, :production
    disable :protection
end


require_relative '../app/jyotish/lib/main'

require_relative '../app/routes/system'