require 'bundler'
Bundler.require

class ChatLogs < Sinatra::Base
  configure do |c|
    set :root, File.dirname(__FILE__)
    set :views, Proc.new{ File.join(root, "app", "views")}
  end
end

require './app/routes'