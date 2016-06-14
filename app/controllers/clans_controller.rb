class ClansController < ApplicationController
  before_action :set_clan, only: [:show]


  def index
    param! :order, String, in: %w(asc desc), transform: :downcase, default: 'desc'
    param! :sort, String, in: Player.sort_allowed_by_country?, default: Player.sort_default_by_country
  end

  def show
    param! :clanId, Integer
  end


  def set_clan
    @clan = Team.find(params[:clanId])
  end
end
