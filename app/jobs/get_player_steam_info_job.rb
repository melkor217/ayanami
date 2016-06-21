class GetPlayerSteamInfoJob < ApplicationJob
  def perform(options = {})
    logger.warn options.to_s
    uniqueid = UniqueId.find_by!(options)
    # Do something later
    if uniqueid
      s = Redis::Semaphore.new(:steam, Rails.application.config.semaphore)
      s.lock
      begin
        if uri = SteamId.steam_profile_url(uniqueid.uniqueId, format: :xml)
          doc = Nokogiri::XML(Net::HTTP.get(uri))
          logger.debug("Getting info for player #{uri.to_s}")
          raise IOError, 'Incorrect XML :(' if doc.xpath('//profile/steamID64').text.to_i == 0

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
        end

        uniqueid.steamUpdated = Time.now
        uniqueid.save
      rescue
        logger.warn("Failed to get steam profile for #{id64}")
        sleep 5
        s.unlock
        raise
      ensure
        s.unlock
      end
    end
  end
end
