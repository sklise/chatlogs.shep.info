require 'bundler'
Bundler.require

configure do |c|
  # enable :sessions
  set :cache, Dalli::Client.new
  set :enable_cache, true
  set :short_ttl, 400
  set :long_ttl, 3600
  set :root, File.dirname(__FILE__)
  set :views, Proc.new{ File.join(root, "app", "views")}
  set :scss, :style => :compact
end

require './app/routes'