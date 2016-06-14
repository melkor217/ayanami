class Team < Clan
  has_many :players, foreign_key: :clan, primary_key: :clanId
end
