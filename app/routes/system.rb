get '/' do
    erb :index
end

STORE = {}

post '/submit' do
    uuid = SecureRandom.uuid

    STORE[uuid] = {
        name:   params[:name].to_f,
        lat:    params[:lat].to_f,
        lon:    params[:lon].to_f,
        year:   params[:year].to_i,
        month:  params[:month].to_i,
        day:    params[:day].to_i,
        hour:   params[:hour].to_i,
        minute: params[:minute].to_i,
        timezone_offset: 0,
    }

    redirect "/#{uuid}"
end

get '/:uuid' do
    @uuid = params[:uuid]
    data  = STORE[@uuid]
    halt 404, "Unknown id" unless data

    @name  = data[:name]
    lat    = data[:lat]
    lon    = data[:lon]
    year   = data[:year]
    month  = data[:month]
    day    = data[:day]
    hour   = data[:hour]
    minute = data[:minute]
    timezone_offset = data[:timezone_offset]

    puts "Received: #{lat}, #{lon} on #{year}-#{month}-#{day} #{hour}:#{minute}"

    @data = consolidated_data_and_charts(lat, lon, year, month, day, hour, minute, timezone_offset, @uuid, "./public/tmp/")
    erb :chart
end

get '/utc_time/now.json' do
    utc_timestamp = Time.now
    lat    = 0
    lon    = 0
    year   = utc_timestamp.year
    month  = utc_timestamp.month
    day    = utc_timestamp.day
    hour   = utc_timestamp.hour
    minute = utc_timestamp.minutes
    consolidated_data(lat, lon, year, month, day, hour, minute).to_json
rescue => error
    { message: error.message }.to_json
end

get '/utc_time/:utc_timestamp.json' do
    utc_timestamp = Time.parse(params[:utc_timestamp])
    lat    = 0
    lon    = 0
    year   = utc_timestamp.year
    month  = utc_timestamp.month
    day    = utc_timestamp.day
    hour   = utc_timestamp.hour
    minute = utc_timestamp.minutes
    consolidated_data(lat, lon, year, month, day, hour, minute).to_json
rescue
    { message: 'That didn\'t work...' }.to_json
end

not_found do
    redirect '/'
end