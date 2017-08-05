require 'open-uri'
require 'json'

def get_users(path, users)
  File.open(path, 'r') do |f1|  
    while line = f1.gets  
      line = line.gsub(/\n/,"")
      users << line  
    end  
  end
end

def parse(hash, i)
  r = "nil"
  if hash['LeaderboardRankings'][i] != nil
    r = hash['LeaderboardRankings'][i]["CurrentMMR"]
  end
  return r
end

def print_data(data)
  puts "Name:\t\t|QM:\t|HL:\t|TL:\t|UD:\t|URL:"
  # 8 char per \t
  data.each do |ary|
    for i in 0..5
      if i == 0 && ary[i].length < 8
        print "#{ary[i]}\t\t"
      elsif i == 0
        print "#{ary[i]}\t"
      else
        print "|#{ary[i]}\t"
      end
    end
    print "\n"
  end
end

def get_player_info(user)
  if user == "\n"
    return
  end

  path = "https://api.hotslogs.com/Public/Players/1/#{user.gsub(/#/, '_')}"

  data_from_web = open(path).read
  hash = JSON.parse(data_from_web)
  results = Array.new
  results << "#{hash['Name']}"
  results << parse(hash, 0)
  results << parse(hash, 1)
  results << parse(hash, 2)
  results << parse(hash, 3)
  results << "<a href=\"https://www.hotslogs.com/Player/Profile?PlayerID=#{hash["PlayerID"]}\"> HotsLogs Link </a>"
  return results
end

def query(path)
  puts path
  data = Array.new
  users = Array.new
  #path = ARGV[0]
  get_users(path, users)
  users.each do |user|
    data << get_user_info(user)
  end
  return data
  #print_data data
end
