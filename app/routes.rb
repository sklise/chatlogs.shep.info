require 'uri'
uri = URI.parse ENV['REDISTOGO_URL']

get '/' do
  erb :front
end

# 404 Error
not_found do
  erb :notfound
end

get '/thesisweek' do
  erb :thesisweek
end

get '/:year/:month/:date' do
  date = Date.parse("#{params[:year]}/#{params[:month]}/#{params[:date]}")

  @redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

  length = @redis.llen('messages:itp')
  @allmessages = @redis.lrange 'messages:itp', 0, length

  @messages = []

  day_start = date.to_time.to_i*1000
  day_end = (date+1).to_time.to_i*1000

  @allmessages.each do |message|
    message = JSON.parse(message)
    if !message["timestamp"].nil? && message["timestamp"].to_i > day_start && message["timestamp"].to_i < day_end
      @messages.push message
    end
  end

  erb :chatlog
end