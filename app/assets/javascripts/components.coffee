#= require_tree ./components


#$(window).unload(function (e) {
#    e.preventDefault();
#    alert("Back was pressed!");
#});

@updateQueryStringParameter = (uri, key, value) ->
# http://uri.com/page?key=old
# ->
# http://uri.com/page?key=value
#
# http://uri.com/page?qwe=123
# ->
# http://uri.com/page?qwe=123&key=value
  re = new RegExp('([?&])' + key + '=.*?(&|$)', 'i')
  separator = if uri.indexOf('?') != -1 then '&' else '?'
  if uri.match(re)
    uri = uri.replace(re, '$1' + key + '=' + value + '$2')
  else
    uri = uri + separator + key + '=' + value
  uri.replace(/[^=&]+=(&|$)/g, '').replace /&$/, ''

String::toHHMMSS = ->
  sec_num = parseInt(this, 10)
  # don't forget the second param
  hours = Math.floor(sec_num / 3600)
  minutes = Math.floor((sec_num - (hours * 3600)) / 60)
  seconds = sec_num - (hours * 3600) - (minutes * 60)
  if hours < 10
    hours = '0' + hours
  if minutes < 10
    minutes = '0' + minutes
  if seconds < 10
    seconds = '0' + seconds
  hours + ':' + minutes + ':' + seconds

String::addCommas = ->
  nStr = this
  x = nStr.split('.')
  x1 = x[0]
  x2 = if x.length > 1 then '.' + x[1] else ''
  rgx = /(\d+)(\d{3})/
  while rgx.test(x1)
    x1 = x1.replace(rgx, '$1' + ',' + '$2')
  x1 + x2

@getQueryParam = (param) ->
# http://test.url/page.html?param=a&b=c
# ->
# param
  found = undefined
  window.location.search.substr(1).split('&').forEach (item) ->
    if param == item.split('=')[0]
      found = item.split('=')[1]
    return
  found

# ---
# generated by js2coffee 2.2.0

