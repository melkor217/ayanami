class SteamId
  def self.steam_profile_url(steamid, options = {})
    return nil if not /^[0-9]:[0-9]+$/.match(steamid)
    prefix = steamid.split(':').first.to_i
    steamid = steamid.split(':').last.to_i
    id64 = 76561197960265728 + prefix + steamid*2
    uri = "http://steamcommunity.com/profiles/#{id64}/"
    if options[:format] == :xml
      uri += '?xml=1'
    end
    return URI(uri)
  end
  def self.steam_group_url(options)
    return nil if not /^[0-9A-z\-]+$/.match(options[:groupURL])
    if options[:format] == :xml
      URI("http://steamcommunity.com/groups/#{options[:groupURL]}/memberslistxml/?xml=1")
    else
      URI("http://steamcommunity.com/groups/#{options[:groupURL]}/")
    end
  end

  def self.to32(steamid64)
    tmp = steamid64.to_i - 76561197960265728
    x = tmp % 2
    y = tmp / 2
    return "#{x}:#{y}"
  end
end