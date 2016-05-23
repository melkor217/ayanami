json.extract! @player, :id, :lastName, :kills, :activity

json.avatarIcon @player.unique_ids.first.avatar_icon

json.partial! 'frags/comments', comments: 123
