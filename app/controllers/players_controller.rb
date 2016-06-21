class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :killstats, :weapons]

  # GET /players
  # GET /players.json
  def index
    param! :order, String, in: %w(asc desc), transform: :downcase, default: "desc"
    param! :sort, String, in: Player.sort_allowed?, default: Player.sort_default
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]


    puts params
    if request.format.json?
      puts params
      if params[:country_countryId]
        query = Country.find(params[:country_countryId]).players.where(hideranking: 0)
      elsif params[:clan_clanId]
        query = Team.find(params[:clan_clanId]).players.where(hideranking: 0)
      else
        query = Player.where(hideranking: 0)
      end
      if params[:search]
        query = query.name_search(params[:search])
      end
      @total = query.count
      @players = query.with_kpd.uniorder(params[:sort], params[:order]).limit(params[:limit]).offset params[:offset]
    else
      @scope = Player.where(hideranking: 0)
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @total = Player.total
    @skill_limits = {
        min: Player.all.cached_minimum(:skill),
        max: Player.all.cached_maximum(:skill)
    }
  end

  def killstats
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    param! :order, String, in: %w(asc desc), transform: :downcase, default: "desc"
    param! :sort, String, in: ['kills', 'deaths', 'kpd'], default: 'kills'

    if request.format.json?
      ks = @player.killstats
      puts ks
      ks = ks.sort_by do |k, v|
        val = v[params[:sort].to_sym].to_i
        if params[:order].to_sym == :asc
          val
        else
          -val
        end
      end

      ks = ks.to_a
      puts ks
      @total = ks.count
      @killstats = ks[params[:offset]..(params[:offset]+params[:limit])]
    end
  end

  def weapons
    @weapons = @player.weapons
  end

  private
  # Use callbacks to share common setup or constraints between actions.


  def set_player
    @player = Player.find(params[:id])
  end
end
