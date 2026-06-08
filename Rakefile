task :run do
    require_relative './config/initialize.rb'
    Sinatra::Application.run!
end

task :no_run do
    require_relative './config/initialize.rb'
end

task :bump do
    `git submodule update --remote app/jyotish`
    `git add app/jyotish && git commit -m "Bump jyotish submodule"`
end