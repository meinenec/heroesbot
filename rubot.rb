require 'discordrb'
require_relative 'helpers.rb'

bot = Discordrb::Commands::CommandBot.new token: 'MzQzNDg0MTYxMDc3NjczOTg2.DGe6gg.0uSMFeIC2QWdzEmZjd3FDygntt0', client_id: 343484161077673986, prefix: '!'

bot.message(with_text: 'ping') do |event|
  event.respond 'PONG'
end

bot.command :help do |event|
  "Heroes Bot commands:
  'ping' to make sure Heroes Bot is alive
  '!random [low] [high]' to generate a random within the range
  '!player [BattleTag]' or 'player [hotslogs id]' for ranked data
  '!team [player1] [player2] ... [player5]' for multiple players
  '!contribute' for github repo"
end

bot.command :contribute do |event|
  "Find help or contribute on gihub:\nhttps://github.com/meinenec/heroesbot"
end

bot.command :random do |event, min, max|
  rand(min.to_i .. max.to_i)
end

bot.command :player do |event, name|
  response = get_player_info(name)
  "from hotslogs.com: \n#{response}"
end

bot.command :team do |event, p1, p2, p3, p4, p5|
  response = get_team_info(p1, p2, p3, p4, p5)
  "From hotslogs.com: \n#{response}"
end

bot.command :hero do |event, hero|
  response = get_hero_info(hero)
  "From masterleague.net: \n#{response}"
end

bot.run
