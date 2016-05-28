class GetPlayerSteamInfoJob < ApplicationJob
  def perform(options = {})
    uniqueid = UniqueId.find_by!(options)
    # Do something later
    if uniqueid and /^[0-9]:[0-9]+$/.match(uniqueid.uniqueId)
      uri = SteamId.steam_profile_url(uniqueid.uniqueId, format: :xml)
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
