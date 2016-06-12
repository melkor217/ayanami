class ClansController < ApplicationController
  before_action :set_clan, only: [:show]


  def show
    param! :clanId, Integer
  end


  def set_clan
    @clan = Clan.find(params[:clanId])
  end
end
