{ProgressBar, Skill, Ranking} = require('commonjs/shared')
{VKWidget} = require('commonjs/vk')

PlayerHeader = React.createClass
  componentDidUpdate: ->
    if @state and @state.player and @state.player.lastName
      document.title = @state.player.lastName + " - Ayanami"
  componentDidMount: ->
    if @props.url
      @serverRequest = $.get @props.url, (data) =>
        @setState player: data
  getInitialState: ->
    player: {}
    steam_icon: ''
  render: ->
    {a, div, img, ul, li} = React.DOM
    div
      className: "container-fluid"
      children: [
        div
          className: "panel panel-default"
          children: [
            div
              style: {verticalAlign: 'middle'}
              className: "panel-heading clearfix"
              children: [
                img
                  style: {verticalAlign: 'middle'}
                  src: @state.player.avatarIcon
                  width: 30
                  height: 30
                React.DOM.h2 {style: {display: 'inline', marginLeft: '0.3em', verticalAlign: 'middle'}},
                    @state.player.lastName
                if @state.player.steamUrl
                  a {href: @state.player.steamUrl, className: "btn-link"},
                    img
                     src: @props.steam_icon
                     style: {verticalAlign: 'middle', 'margin-left': '0.3em'}
                if @state.player and @state.player.path
                  React.createElement(VKWidget, elementId: 'vk_like', path: @state.player.path, title: @state.player.lastName)
              ]
            div
              className: "panel-body"
              children: [
                ul
                  className: "nav nav-pills"
                  children: [
                    if @state.player.pathname
                      li
                        className:
                          if @state.player.pathname == window.location.pathname
                            'active'
                          else
                            ''
                        children: [
                          a
                            href: @state.player.pathname
                            'General'
                        ]
                    if @state.player.killstatsPath
                      li
                        className:
                          if @state.player.killstatsPath == window.location.pathname
                            'active'
                          else
                            ''
                        children: [
                          a
                            href: @state.player.killstatsPath
                            'Killstats'
                        ]
                    if @state.player.weaponsPath
                      li
                        className:
                          if @state.player.weaponsPath == window.location.pathname
                            'active'
                          else
                            ''
                        children: [
                          a
                            href: @state.player.weaponsPath
                            'Weapons'
                        ]
                    if @state.player.fragsPath
                      li
                        className:
                          if @state.player.fragsPath == window.location.pathname
                            'active'
                          else
                            ''
                        children: [
                          a
                            href: @state.player.fragsPath
                            'Frags'
                        ]
                  ]
              ]
          ]
      ]

Player = React.createClass
  getInitialState: ->
    player:
      lastName: 'undefined'
      kills: 0
      deaths: 0
      headshots: 0
      skill:
        points: 1000
        last_change: 0
        activity: 0
        connection_time: 0
  getDefaultProps: ->
    total: 1
    url: ''
    skill_limits:
      min: 0
      max: 2000
  render: ->
    {div, img, table, tbody, tr, td, a} = React.DOM
    div
      children: [
        React.createElement(PlayerHeader, ref: 'header')
        div
          className: "container"
          children: [
            table
              className: "table table-bordered",
              tbody
                children: [
                  tr null,
                    td null, "Name"
                    td
                      children: [
                        img
                          src: @state.player.avatarIcon
                          width: 30
                          height: 30
                        @state.player.lastName
                      ]
                  tr null,
                    td null, "Skill"
                    td null, React.createElement(ProgressBar,
                      current: @state.player.skill.points,
                      value: React.createElement(Skill, @state.player.skill),
                      limits: @props.skill_limits)
                  tr null,
                    td null, "Ranking"
                    td null, React.createElement(Ranking, current: @state.player.ranking, total: @props.total)
                  if @state.player.country
                    tr null,
                        td null, "Country"
                        td null,
                          a {href: @state.player.country.path, className: "btn-link"},
                            img
                              src: @state.player.country.icon
                            "#{@state.player.country.country} (#{@state.player.country.flag})"
                  tr null,
                    td null, "Kills"
                    td null, @state.player.kills.toString().addCommas()
                  tr null,
                    td null, "Headshots"
                    td null, @state.player.headshots.toString().addCommas()
                  tr null,
                    td null, "Deaths"
                    td null, @state.player.deaths.toString().addCommas()
                  tr null,
                    td null, "K/D"
                    td null, Math.round(100 * @state.player.kills / Math.max(@state.player.deaths,1)) / 100
                  tr null,
                    td null, "Activity"
                    td null, React.createElement(ProgressBar, current: @state.player.activity, value: "#{@state.player.activity}%")
                  tr null,
                    td null, "ConnectionTime"
                    td null, "#{@state.player.connection_time}".toHHMMSS()
                ]
          ]
      ]
  componentDidMount: ->
    @serverRequest = $.get @props.url, (data) =>
      @setState player: data
      @refs.header.setState player: data



module.exports.Player = Player
module.exports.PlayerHeader = PlayerHeader
