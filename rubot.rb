require 'discordrb'

bot = Discordrb::Bot.new token: 'MzQzNDg0MTYxMDc3NjczOTg2.DGe6gg.0uSMFeIC2QWdzEmZjd3FDygntt0', client_id: 343484161077673986

bot.message(with_text: 'ping') do |event|
  event.respond 'PONG'
end

bot.message(with_text: player) do |event|
  event.respond get_player_info(player)
end


bot.run
