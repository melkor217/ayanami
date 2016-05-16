class WeaponsController < ApplicationController
  before_action :set_weapon, only: [:show, :edit, :update, :destroy]

  # GET /weapons
  # GET /weapons.json
  def index
    param! :order, String, in: %w(asc desc), transform: :downcase, default: "asc"
    param! :sort, String, in: Weapon.sort_allowed?, default: Weapon.sort_default
    param! :search, String, default: nil
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    query = Weapon.where(game: 'csgo').uniorder(params[:sort], params[:order])
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
    @frags = @weapon.frags_grouped.to_a[params[:offset],params[:limit]]
    @total = @weapon.frags_grouped.count
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_weapon
    @weapon = Weapon.find_by(code: params[:code], game: 'csgo')
  end
end
