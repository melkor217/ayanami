class FragsController < ApplicationController

  # GET /frags
  # GET /frags.json
  def index
    param! :player_id, Integer, default: nil
    param! :page, Integer, default: 1
    param! :game_game, String, default: Rails.configuration.default_game

    if params[:player_id]
      @frags = Player.find(params[:player_id]).frag.by_game(params[:game_game]).uniorder(:eventTime, :desc).page(params[:page])
    else
      @frags = Frag.by_game(params[:game_game]).uniorder(:eventTime, :desc).page(params[:page])
    end
  end

end
