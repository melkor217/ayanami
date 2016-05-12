class FragsController < ApplicationController

  # GET /frags
  # GET /frags.json
  def index
    param! :id, Integer, default: nil
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    if params[:id]
      @frags = Player.find(params[:id]).frag.page(params[:page])
    else
      @frags = Frag.all.page(params[:page])
    end
  end

  # GET /frags/1
  # GET /frags/1.json
  def show
  end
end
