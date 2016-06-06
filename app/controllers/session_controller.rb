class SessionController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    response = request.env['omniauth.auth']
    if response and response.uid and response.extra.raw_info.personaname
      session[:uid] = response.uid.to_i
      session[:state] = :authorized
      id32 = SteamId.to32(session[:uid])
      personaname = response.extra.raw_info.personaname
      unique_id = UniqueId.find_or_create_by(uniqueId: id32, game: 'ayanami_web') do |id|
        id.personaname = personaname
        GetPlayerSteamInfoJob.set(queue: :urgent).perform_later(game: 'ayanami_web', uniqueId: id32)
      end
      if unique_id and
          (real_id = UniqueId.where.not(game: :ayanami_web).find_by(uniqueId: unique_id.uniqueId)) and
          player = real_id.player
        real_id.personaname = personaname
        real_id.save
        session[:default_game] = :csgo
        GetPlayerSteamInfoJob.set(queue: :urgent).perform_later(game: session[:default_game].to_s, uniqueId: id32)
        redirect_to player_path(player)
      else
        redirect_to root_path
      end
    else
      raise 'Error'
    end
  end

  def destroy
    session[:uid] = nil
    session[:state] = :logged_out
    redirect_to root_path
  end
end
