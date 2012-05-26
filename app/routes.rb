require 'uri'
require 'open-uri'
uri = URI.parse ENV['REDISTOGO_URL']

# 404 Error
not_found do
  erb :notfound
end

get '/thesisweek' do
  erb :thesisweek
end

get '/:channel/:year/:month/:date.json' do
  content_type :json
  AWS::S3::Base.establish_connection!(
    :access_key_id     => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_KEY']
  )
  file = AWS::S3::S3Object.find "chatlogs/itp-#{params['year']}-#{params['month']}-#{params['date']}.js", 'shep.info'
  JSONP JSON.parse(file.value)
end

get '/:channel/:year/:month/:date' do
  AWS::S3::Base.establish_connection!(
    :access_key_id     => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_KEY']
  )
  file = (AWS::S3::S3Object.find "chatlogs/#{params['channel']}-#{params['year']}-#{params['month']}-#{params['date']}.js", 'shep.info').value
  @messages = JSON.parse file
  erb :chatlog
end