get '/api/thelemic_date.json' do
    time = Time.now
    begin
        time = Time.parse(params[:time]) if params[:time]
    rescue
        halt 500, 'Invalid time'
    end
    time_values = time_to_gregorian_datetime_values(time)
    sol, luna, year = gregorian_datetime_to_thelemic_datetime(*time_values)
    unless params[:detailed]
        {
            sol: sol,
            luna: luna,
            year: year,
        }.to_json
    else
        # TODO: implement full response from louismachin.com/api/thelemic_date.json
        # {"evdate_local":"2026-06-14 17:32:28","evdate_utc":"2026-06-14 17:32:28","dow":7,"sunrise":"06:00:00",
        # "is_dst":0,"tz_offset":0,"sol":{"sign":2,"deg":23,"symbol":"â™Šï¸Ž"},"luna":{"sign":2,"deg":18,"symbol":"â™Šï¸Ž"},
        # "year":[5,12],"plain":{"full":"â˜‰ï¸Ž in 23Â° Geminorum : â˜½ï¸Ž in 18Â° Geminorum : dies Solis : Anno â…¤â…¹â…°â…° Ã¦rÃ¦ legis",
        # "sol":"â˜‰ï¸Ž in 23Â° Geminorum","luna":"â˜½ï¸Ž in 18Â° Geminorum","day":"dies Solis","year":"Anno â…¤â…¹â…°â…° Ã¦rÃ¦ legis",
        # "year_alt":"Anno V:xii e.n."},"en":"V:xii"}
        { message: 'In development' }.to_json
    end
end