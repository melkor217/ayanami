class GetPlayerSteamInfoJob < ApplicationJob
  def perform(options = {})
    logger.debug "GetPlayerSteamInfo with #{options.to_s}"
    uniqueid = UniqueId.find_by!(options)
    # Do something later
    if uniqueid
      s = Redis::Semaphore.new(:steam, Rails.application.config.semaphore)
      logger.debug("#{@job_id} Locking: start")
      s.lock || raise('Semaphore timeout')
      logger.debug("#{@job_id} Locking: done")
      begin
        if uri = SteamId.steam_profile_url(uniqueid.uniqueId, format: :xml)
          logger.debug("#{@job_id} Getting info for player #{uri.to_s}")
          $statsd.time 'SteamAPI.response_time.steam_profile' do
            @body = Net::HTTP.start(uri.host, uri.port, read_timeout: 15) do |http|
              request = http.request(Net::HTTP::Get.new(uri))
              $statsd.increment "SteamAPI.response_code.#{request.code.to_s}"
              (request.kind_of? Net::HTTPSuccess) ? request.body : nil
            end
          end
          logger.debug("#{@job_id} Done")
          doc = Nokogiri::XML(@body)
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
        logger.warn("#{@job_id} Failed to get steam profile for #{uniqueid.uniqueId}")
        sleep 5
        s.unlock
        raise
      ensure
        logger.debug "#{@job_id} Finishing.. #{uri.to_s}"
        s.unlock
      end
    end
  end
end
