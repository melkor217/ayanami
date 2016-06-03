{tbody, thead, table, tr, td, th, a} = React.DOM

ServerList = React.createClass
  componentDidMount: ->
    if @props.url
      @serverRequest = $.get @props.url, (data) =>
        @setState servers: data
  getInitialState: ->
    servers: []
  row: (data) ->
    tr
      children: [
        td {}, data.name
        td null, a
          className: "btn btn-info"
          href: "steam://connect/#{data.publicaddress}", 'Connect'
        td {style: {fontFamily: 'monospace'}}, data.publicaddress
        td null, "#{data.livestats_players} (#{data.act_players}) / #{data.max_players}"
        td null, data.kills
        td null, data.headshots
        td null, data.act_map
        td null, data.map_started
      ]
  render: ->
    {tbody, thead, table, tr, td, th, a} = React.DOM
    table
      className: "table fixed table-bordered"
      children: [
        thead
          children: [
            tr
              children: [
                th
                  className: 'col-md-2', 'Name'
                th {}, 'Link'
                th
                  className: 'col-md-2', 'IP Address'
                th
                  className: 'col-sm-1', 'Players'
                th
                  className: 'col-sm-1', 'Kills'
                th
                  className: 'col-sm-1', 'Headshots'
                th
                  className: 'col-md-2', 'Current map'
                th
                  className: 'col-md-2', 'Map time'
              ]
          ]
        tbody
          children: [
            @row(server) for server in @state.servers
          ]
      ]


module.exports.ServerList = ServerList
