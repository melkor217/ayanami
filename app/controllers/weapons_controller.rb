class WeaponsController < ApplicationController
  before_action :set_weapon, only: [:show, :edit, :update, :destroy]

  # GET /weapons
  # GET /weapons.json
  def index
    param! :order, String, in: %w(asc desc), transform: :downcase, default: "desc"
    param! :sort, String, in: Weapon.sort_allowed?, default: Weapon.sort_default
    param! :search, String, default: nil
    param! :limit, Integer, in: (10..100), default: 100
    param! :game_game, String, default: Rails.configuration.default_game
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    query = Weapon.all
    if params[:game_game]
      query = query.where(game: params[:game_game])
    end

    query = query.uniorder(params[:sort], params[:order])
    if params[:search]
      query = query.name_search(params[:search])
    end

    @total = query.count
    query = query.limit(params[:limit]).offset params[:offset]
    @weapons = query
  end

  # GET /weapons/1
  # GET /weapons/1.json
  def show
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    if request.format.json?
      @frags = @weapon.frags_grouped.to_a[params[:offset],params[:limit]]
      @total = @weapon.frags_grouped.count
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_weapon
    param! :game_game, String, default: Rails.configuration.default_game
    @weapon = Weapon.find_by!(code: params[:code], game: params[:game_game])
  end
end
