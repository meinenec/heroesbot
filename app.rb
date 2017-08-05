require 'sinatra'
require 'json'
require_relative 'helpers.rb'

set :bind, '0.0.0.0'

get '/' do
end

get '/player/:player' do
  "#{get_player_info(params['player'])}"
end
