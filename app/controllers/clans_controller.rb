class ClansController < ApplicationController
  before_action :set_clan, only: [:show]


  def index
    param! :order, String, in: %w(asc desc), transform: :downcase, default: 'desc'
    param! :sort, String, in: %w{name homepage game hidden mapregion skill kills headshots deaths members activity}, default: 'skill'
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    query = Player.by_team
    @count = query.count(:all).count
    query = query.uniorder(params[:sort], params[:order]).limit(params[:limit]).offset params[:offset]
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
