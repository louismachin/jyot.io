require 'json'

CITIES = File.readlines(File.expand_path('../../config/cities15000.txt', __dir__), encoding: 'UTF-8').map do |line|
    c = line.chomp.split("\t")
    {
        name:  c[1],           # display name
        ascii: c[2].downcase,  # for matching
        cc:    c[8],           # country code
        lat:   c[4].to_f,
        lon:   c[5].to_f,
        tz:    c[17],          # IANA name, e.g. "Europe/London"
        pop:   c[14].to_i,     # for ranking
    }
end

puts "#{CITIES.length} cities loaded..."

get '/cities' do
    content_type :json
    q = params[:q].to_s.strip.downcase
    if q.length < 2
        [].to_json
    else
        CITIES
            .select { |c| c[:ascii].include?(q) }
            .sort_by { |c| [c[:ascii].start_with?(q) ? 0 : 1, -c[:pop]] }  # prefix matches first, then biggest cities
            .first(10)
            .to_json
    end
end