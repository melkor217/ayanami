class Team < Clan
  has_many :players, foreign_key: :clan, primary_key: :clanId

  def cached_count(options = {})
    options.merge!(expires_in: 10.minutes)
    Rails.cache.fetch({mode: :clan_count}, options) do
    end
    end
end
