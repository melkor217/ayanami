class ClansController < ApplicationController
  before_action :set_clan, only: [:show]


  def index
    param! :order, String, in: %w(asc desc), transform: :downcase, default: 'desc'
    param! :sort, String, in: %w{name homepage game hidden mapregion skill kills headshots deaths members activity}, default: 'skill'
    query = Player.by_team.uniorder(params[:sort], params[:order])
    if params[:search]
      query = query.country_search(params[:search])
    end
    @clans = query
  end

  def show
    param! :clanId, Integer
  end


  def set_clan
    @clan = Team.find(params[:clanId])
  end
end
