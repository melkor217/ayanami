module FragsHelper
  def player_link(id)
    link_to(Player.find(id).lastName, Player.find(id),{:class=>"btn-link"})
  end
end
