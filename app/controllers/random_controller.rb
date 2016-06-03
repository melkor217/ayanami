class RandomController < ApplicationController
  def index
    urls = [
        frags_path,
        players_path,
        countries_path,
        servers_path,
        SteamId.steam_group_url(SteamGroup.sitegroup)
    ]
    redirect_to urls.sample
  end
end
