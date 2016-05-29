$ ->
  $result = $('#eventsResult')
  $('#table').on('all.bs.table', (e, name, args) ->
#console.log('Event:', name, ', data:', args);
    return
  ).on('dbl-click-row.bs.table', (e, row, $element) ->
    $result.text 'Event: dbl-click-row.bs.table'
    return
  ).on('sort.bs.table', (e, name, order) ->
    history.pushState {
      turbolinks: true
      url: window.location.href
    }, 'new title', updateQueryStringParameter(updateQueryStringParameter(window.location.href, 'sort', name), 'order', order)
    $(window).scrollTop 0
    $result.text 'Event: sort.bs.table'
    return
  ).on('check.bs.table', (e, row) ->
    $result.text 'Event: check.bs.table'
    return
  ).on('uncheck.bs.table', (e, row) ->
    $result.text 'Event: uncheck.bs.table'
    return
  ).on('check-all.bs.table', (e) ->
    $result.text 'Event: check-all.bs.table'
    return
  ).on('uncheck-all.bs.table', (e) ->
    $result.text 'Event: uncheck-all.bs.table'
    return
  ).on('load-success.bs.table', (e, data) ->
    $result.text 'Event: load-success.bs.table'
    return
  ).on('load-error.bs.table', (e, status) ->
    $result.text 'Event: load-error.bs.table'
    return
  ).on('column-switch.bs.table', (e, field, checked) ->
    $result.text 'Event: column-switch.bs.table'
    return
  ).on('page-change.bs.table', (e, number, size) ->
#history.pushState("object or string representing the state of the page", "new title", window.location+"?page="+number+'&limit='+size);
#history.pushState("object or string representing the state of the page", "new title", window.location+"?page="+number+'&limit='+size);
    history.pushState {
      turbolinks: true
      url: window.location.href
    }, 'new title', updateQueryStringParameter(updateQueryStringParameter(window.location.href, 'page', number), 'limit', size)
    $(window).scrollTop 0
    $result.text 'Event: page-change.bs.table'
    return
  ).on 'search.bs.table', (e, text) ->
    history.pushState {
      turbolinks: true
      url: window.location.href
    }, 'new title', updateQueryStringParameter(window.location.href, 'search', text)
    $(window).scrollTop 0
    $result.text 'Event: search.bs.table'
    return
  return
