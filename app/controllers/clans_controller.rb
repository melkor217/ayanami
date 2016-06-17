class ClansController < ApplicationController
  before_action :set_clan, only: [:show]


  def index
    param! :order, String, in: %w(asc desc), transform: :downcase, default: 'desc'
    param! :sort, String, in: %w{name homepage game hidden mapregion skill kills headshots deaths members activity tag}, default: 'skill'
    param! :limit, Integer, in: (10..100), default: 25
    param! :members, Integer, min: 1, default: 3
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]

    if request.format.json?
      @count = Team.where('members >= ?', params[:members]).count
      query = Player.by_team(params[:members])
      query = query.uniorder(params[:sort], params[:order]).limit(params[:limit]).offset params[:offset]
      if params[:search]
        query = query.country_search(params[:search])
      end
      @clans = query
    end
  end

  def show
  end


  def set_clan
    param! :clanId, Integer
    @clan = Player.where(clan: params[:clanId]).by_team(1).first
  end
end
