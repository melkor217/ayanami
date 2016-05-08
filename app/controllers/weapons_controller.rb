class WeaponsController < ApplicationController
  before_action :set_weapon, only: [:show, :edit, :update, :destroy]

  # GET /weapons
  # GET /weapons.json
  def index
    param! :order, String, in: %w(asc desc), transform: :downcase, default: "asc"
    param! :sort, String, in: Weapon.sort_allowed?, default: Weapon.sort_default
    param! :search, String, default: nil
    query = Weapon.uniorder(params[:sort],params[:order])
    if params[:search]
      query = query.name_search(params[:search])
    end
    @weapons = query
  end

  # GET /weapons/1
  # GET /weapons/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weapon
      @weapon = Weapon.find(params[:id])
    end
end
