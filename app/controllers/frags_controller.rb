class FragsController < ApplicationController

  # GET /frags
  # GET /frags.json
  def index
    param! :player_id, Integer, default: nil
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    param! :game_game, String, default: Rails.configuration.default_game

    if params[:player_id]
      @frags = Player.find(params[:player_id]).frag.by_game(params[:game_game]).offset(params[:offset]).limit(params[:limit])
    else
      query = Frag.by_game(params[:game_game])
      @total = query.count
      @frags = query.offset(params[:offset]).limit(params[:limit])
    end
  end

end
