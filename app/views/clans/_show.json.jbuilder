json.extract! clan, :clanId, :tag, :name, :homepage, :game, :hidden, :mapregion
if clan.members
  json.extract! clan, :members, :connection_time, :kills, :deaths, :headshots, :skill, :activity
end
