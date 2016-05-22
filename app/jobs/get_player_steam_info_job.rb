class GetPlayerSteamInfoJob < ApplicationJob
  queue_as :default

  def perform(uniqueid)
    # Do something later
    if uniqueid and /^[0-9]:[0-9]+$/.match(uniqueid.uniqueId)
      prefix = uniqueid.uniqueId.split(':').first.to_i
      steamid = uniqueid.uniqueId.split(':').last.to_i
      id64 = 76561197960265728 + prefix + steamid*2

      uri = URI("http://steamcommunity.com/profiles/#{id64}/?xml=1")
      begin
        doc = Nokogiri::XML(Net::HTTP.get(uri))
        uniqueid.avatarFull = doc.xpath('//profile/avatarFull').text
        uniqueid.avatarMedium = doc.xpath('//profile/avatarMedium').text
        uniqueid.avatarIcon = doc.xpath('//profile/avatarIcon').text
      rescue
        logger.warn("Failed to get steam profile for #{id64}")
      end

    end
    uniqueid.steamUpdated = Time.now
    uniqueid.save
    sleep 5
  end
end
