require 'open-uri'
require 'json'

def parse(hash, i)
  r = "nil"
  if hash['LeaderboardRankings'][i] != nil
    r = hash['LeaderboardRankings'][i]["CurrentMMR"]
  end
  return r
end

def get_player_info(user)
  if user == "\n"
    return
  end
  if user =~ /#/ || user =~ /_/
    path = "https://api.hotslogs.com/Public/Players/1/#{user.gsub(/#/, '_')}"
    data_from_web = open(path).read
    hash = JSON.parse(data_from_web)
    if hash['Message'] =~ /error/
      results = "Could not find player #{user} \nTry using their player ID"
    else
      results = "#{hash['Name']} | QM: #{parse(hash, 0)} | UR: #{parse(hash, 1)} | HL: #{parse(hash, 2)} | TL: #{parse(hash, 3)} | URL:\nhttps://www.hotslogs.com/Player/Profile?PlayerID=#{hash["PlayerID"]}"
    end
  else
    path = "https://api.hotslogs.com/Public/Players/#{user}"
    data_from_web = open(path).read
    hash = JSON.parse(data_from_web)
    if hash['Message'] =~ /error/
      results = "Could not find player #{user}"
    else
      results = "#{hash['Name']} | QM: #{parse(hash, 0)} | UR: #{parse(hash, 1)} | HL: #{parse(hash, 2)} | TL: #{parse(hash, 3)} | URL:\nhttps://www.hotslogs.com/Player/Profile?PlayerID=#{hash["PlayerID"]}"
    end
  end
  return results
end

def get_team_info(p1, p2, p3, p4, p5)
  results = "#{get_player_info(p1)}\n#{get_player_info(p2)}\n#{get_player_info(p3)}\n#{get_player_info(p4)}\n#{get_player_info(p5)}"
  return results
end
