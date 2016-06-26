class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  # GET /chats
  # GET /chats.json
  def index
    param! :limit, Integer, in: (10..100), default: 25
    param! :page, Integer, default: 1
    param! :offset, Integer, default: (params[:page]-1)*params[:limit]
    param! :game_game, String, default: Rails.configuration.default_game

    if request.format.json?
      query = Chat.all
      @messages = query.order(id: :desc).limit(params[:limit]).offset(params[:offset])
      @total = query.count
    end
  end

  # GET /chats/1
  # GET /chats/1.json
  def show
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_chat
    @chat = Chat.find(params[:id])
  end
end
