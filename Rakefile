task :run do
    require_relative './config/initialize'
    Sinatra::Application.run!
end

task :no_run do
    require_relative './config/initialize'
end

task :bump do
    `git submodule update --remote app/jyotish`
    `git add app/jyotish && git commit -m "Bump jyotish submodule"`
end

task :link do
    require_relative './config/initialize'
    puts consolidated_data_by_datetime(50.9039, -1.4043, Time.now)
end