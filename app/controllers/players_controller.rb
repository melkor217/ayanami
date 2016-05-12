class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    param! :order, String, in: %w(asc desc), transform: :downcase, default: "desc"
    param! :sort, String, in: Player.sort_allowed?, default: Player.sort_default
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    param! :search, String, default: nil

    query = Player.where(hideranking: 0)
    @total = query.count
    query = query.with_kpd
    if params[:search]
      query = query.name_search(params[:search]).limit(params[:limit])
    end
    @players = query.uniorder(params[:sort], params[:order]).limit(params[:limit]).offset params[:offset]
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.


  def set_player
    @player = Player.find(params[:id])
  end
end
