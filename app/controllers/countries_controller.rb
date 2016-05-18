class CountriesController < ApplicationController
  before_action :set_country, only: [:show]

  # GET /countries
  # GET /countries.json
  def index
    param! :order, String, in: %w(asc desc), transform: :downcase, default: 'desc'
    param! :sort, String, in: Player.sort_allowed_by_country?, default: Player.sort_default_by_country
    param! :search, String, default: nil
    #@countries = Player.by_country.order(params[:sort] => params[:order])
    query = Player.by_country.uniorder(params[:sort], params[:order])
    if params[:search]
      query = query.country_search(params[:search])
    end
    @countries = query
  end

  # GET /countries/1
  # GET /countries/1.json0
  def show
    param! :order, String, in: %w(asc desc), transform: :downcase, default: 'desc'
    param! :sort, String, in: Player.sort_allowed?, default: Player.sort_default
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :search, String, default: nil
    param! :countryId, String, default: nil

    @scope = Player.where(hideranking: 0)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_country
    @country = Country.find(params[:countryId])
  end
end
