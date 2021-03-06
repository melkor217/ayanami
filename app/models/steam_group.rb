class SteamGroup < ApplicationRecord
  def self.try_find_by(options = {})
    group = SteamGroup.find_by(options)
    return group if group
    GetGroupSteamInfoJob.perform_later(options)
    return nil
  end

  def self.sitegroup(options = {})
    Rails.cache.fetch({mode: :steamgroup}, options) do
      self.try_find_by(groupURL: Option.find_by!(keyname: 'steamgroup').value)
    end
  end
end
