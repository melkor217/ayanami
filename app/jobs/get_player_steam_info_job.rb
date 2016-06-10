class GetPlayerSteamInfoJob < ApplicationJob
  def perform(options = {})
    logger.warn options.to_s
    uniqueid = UniqueId.find_by!(options)
    # Do something later
    if uniqueid and (uri = SteamId.steam_profile_url(uniqueid.uniqueId, format: :xml))
      begin
        doc = Nokogiri::XML(Net::HTTP.get(uri))
        logger.debug("Getting info for group #{uri.to_s}")
        raise 'Incorrect xml' if (id64 = doc.xpath('//profule/steamID64')) and id64.to_i != 0
        uniqueid.avatarFull = doc.xpath('//profile/avatarFull').text
        uniqueid.avatarMedium = doc.xpath('//profile/avatarMedium').text
        uniqueid.avatarIcon = doc.xpath('//profile/avatarIcon').text
        uniqueid.vacBanned = doc.xpath('//profile/vacBanned').text
        uniqueid.memberSince = doc.xpath('//profile/memberSince').text
        uniqueid.isLimitedAccount = doc.xpath('//profile/isLimitedAccount').text
        uniqueid.location = doc.xpath('//profile/location').text
        uniqueid.customURL = doc.xpath('//profile/customURL').text
        uniqueid.realname = doc.xpath('//profile/realname').text
        uniqueid.personaname = doc.xpath('//profile/steamID').text
      rescue
        logger.warn("Failed to get steam profile for #{id64}")
      end

    end
    uniqueid.steamUpdated = Time.now
    uniqueid.save
    sleep 0.5 if self.queue_name != :urgent
  end
end
