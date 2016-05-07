# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5000.times do
  Player.create do |player|
    player.game = 'csgo'
    player.lastName = (RandomWord.adjs.next.to_s + ' ' + RandomWord.nouns.next.to_s).titleize[0..63]
    player.activity = rand (0..100)
    player.kills = rand (0..1000)
    player.deaths = (player.kills * (rand (0.6..1.4))).round
    player.skill = (player.kills.to_f / [player.deaths,1].max)*1000*(rand (0.9 .. 1.1))
    player.connection_time = player.kills * (rand (8.0 .. 13.0)).round
    player.headshots = rand (0 .. player.kills)
    country = Country.offset(rand(Country.count)).first
    player.country = country
    player.flag = country.flag
  end
end