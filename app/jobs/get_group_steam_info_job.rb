class GetGroupSteamInfoJob < ApplicationJob
  def perform(options = {})
    puts options.to_s
    puts self.queue_name
    # Do something later
    options[:format] = :xml
    if (uri = SteamId.steam_group_url(options))
      begin
        record = SteamGroup.find_or_initialize_by(options) do |group|
          doc = Nokogiri::XML(Net::HTTP.get(uri))
          logger.debug("Getting info for player #{uri.to_s}")
          group.groupID = doc.xpath('//memberList/groupDetails/groupID64').text.to_i
          group.groupName = doc.xpath('//memberList/groupDetails/groupName').text
          group.summary = doc.xpath('//memberList/groupDetails/summary').text
          group.avatarIcon = doc.xpath('//memberList/groupDetails/avatarIcon').text
          group.avatarMedium = doc.xpath('//memberList/groupDetails/avatarMedium').text
          group.avatarFull = doc.xpath('//memberList/groupDetails/avatarFull').text
          group.memberCount = doc.xpath('//memberList/memberCount').text
        end
        record.save
      rescue
        logger.warn("Failed to get group profile for #{options.to_s}")
      end

    end
    sleep 5 if self.queue_name != :urgent
  end
end
