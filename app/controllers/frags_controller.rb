class FragsController < ApplicationController

  # GET /frags
  # GET /frags.json
  def index
    param! :player_id, Integer, default: nil
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    param! :game_game, String, default: Rails.configuration.default_game

    if request.format.json?
      if params[:player_id]
        query =  Player.find(params[:player_id]).frag(params[:game_game])
        @frags = query.order(id: :desc).offset(params[:offset]).limit(params[:limit])
        @total = query.count
      else
        query = Frag.by_game(params[:game_game])
        @total = 50000
        @frags = query.order(id: :desc).offset(params[:offset]).limit(params[:limit])
      end
    end
  end
end
