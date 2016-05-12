class FragsController < ApplicationController

  # GET /frags
  # GET /frags.json
  def index
    param! :player_id, Integer, default: nil
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    if params[:player_id]
      @frags = Player.find(params[:player_id]).frag.uniorder(:eventTime, :desc).page(params[:page])
    else
      @frags = Frag.all.uniorder(:eventTime, :desc).page(params[:page])
    end
  end

end
