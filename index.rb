require 'bundler'
Bundler.require

configure do |c|
  set :root, File.dirname(__FILE__)
  set :views, Proc.new{ File.join(root, "app", "views")}
end

require './app/routes'