@urlFormatter = (value, row, index) ->
  img = undefined
  if row.avatarIcon
    img = '<img width="30" height="30" src="' + row.avatarIcon + '"/>'
  else
    img = '<img width="30" height="30" src=""/>'
  img + '<a class="btn-link" href="' + row.path + '">' + row.lastName + '</a>'

@nameFormatter = (value, row, index) ->
  img = ''
  clan = ''
  if row.avatarIcon
    img = '<img width="30" height="30" src="' + row.avatarIcon + '"/>'
  else
    img = '<img width="30" height="30" src=""/>'

  if row.clan
    clan = '<small><mark>' + row.clan.name + '</mark></small> '
  img + '<a class="btn-link" href="' + row.path + '">' + clan + row.lastName + '</a>'


@runningFormatter = (value, row, index) ->
# Position formatter for tables
#if (getQueryParam('page') && getQueryParam('limit')) {
#    return index + 1 + (getQueryParam('page') -1 )*getQueryParam('limit');
#}
#else {
  index + 1
#}


@countryFormatter = (value, row, index) ->
  '<a class="btn-link" href="' + row.path + '">' + row.country + '</a>'

@flagFormatter = (value, row, index) ->
  if value.icon and value.path
    icon = value.icon
    path = value.path
    name = ''
    name_str = ''
  else
    icon = row.icon
    path = row.path
    name = value
    name_str = '(' + name + ')'
  ret = '<a class="btn-link" href="' + path + '"><img src="' + icon + '" width="32" height="32" alt="' + name + '"/>' + name_str + '</a>'

@serverFormatter = (value, row, index) ->
  '<a class="btn-link" href="' + row.server.path + '">' + row.server.name + '</a>'

@weaponFormatter = (value, row, index) ->
  '<a class="btn-link" href="' + row.path + '"><img height="30" src="' + row.icon + '"/>' + row.name + '</a>'

@fragStyle = (row, index) ->
  classes = ''
  if row.eventType == 'kill'
    classes = 'success'
  if row.eventType == 'death'
    classes = 'danger'
  {classes: classes}

@fragFormatter = (value, row, index) ->
  killer_img = '<img src="" width="30" height="30"/>'
  if row.killer.avatarIcon
    killer_img = '<img src="' + row.killer.avatarIcon + '"/>'
  killer = '<a class="btn-link" href="' + row.killer.path + '">' + killer_img + row.killer.lastName + '</a>'
  victim_img = '<img src="" width="30" height="30"/>'
  if row.victim.avatarIcon
    victim_img = '<img src="' + row.victim.avatarIcon + '"/>'
  victim = '<a class="btn-link" href="' + row.victim.path + '">' + row.victim.lastName + victim_img + '</a>'
  weapon = '<img src="' + row.weapon.icon + '"/>'
  killer + weapon + victim

@progressBar = (value, row_value, limits) ->
  percent = 100 * (row_value - (limits.min)) / (limits.max - (limits.min))
  '<div style="vertical-align: center;overflow: hidden; height: 20px;">' + '<div class="progress"><div role="progressbar" ' + 'class="progress-bar progress-bar-info" aria-valuemin="' + limits.min + '" aria-valuemax="' + limits.max + '" aria-valuenow="' + row_value.toString() + '" style="width:' + percent + '%; height: 20px;"><span>' + value + '</span></div></div></div>'

@skillFormatter = (value, row, index) ->
  sign = if value.last_change > 0 then '+' else ''
  color_class = if value.last_change >= 0 then 'text-success' else 'text-danger'
  str = value.points + ' <small class="' + color_class + '">(' + sign + value.last_change + ')</small>'
  progressBar str, value.points,
    'min': @min
    'max': @max



@activityFormatter = (value, row, index) ->
  progressBar value + '%', value,
    'min': @min
    'max': @max

@killsFormatter = (value, row, index) ->
# css is stewpid -_-
  progressBar value, value,
    'min': @min
    'max': @max

@timeFormatter = (value, row, index) ->
  value.toString().toHHMMSS()


