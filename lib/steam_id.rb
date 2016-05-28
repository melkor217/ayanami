class SteamId
  def self.steam_profile_url(steamid, options = {})
    prefix = steamid.split(':').first.to_i
    steamid = steamid.split(':').last.to_i
    id64 = 76561197960265728 + prefix + steamid*2
    uri = "http://steamcommunity.com/profiles/#{id64}/"
    if options[:format] == :xml
      uri += '?xml=1'
    end
    return URI(uri)
  end
end