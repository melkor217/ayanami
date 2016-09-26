{ProgressBar, Skill, Ranking} = require('commonjs/shared')
{VKWidget} = require('commonjs/vk')

PlayerHeader = React.createClass
  setTitle: ->
    if @state and @state.player and @state.player.lastName
      document.title = @state.player.lastName + " - Ayanami"
  componentDidUpdate: ->
    @setTitle()
  componentDidMount: ->
    if @props.url
      @serverRequest = $.get @props.url, (data) =>
        @setState player: data
  getInitialState: ->
    player: {}
  render: ->
    {a, div, img, ul, li, span} = React.DOM
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
                React.DOM.h2
                  style: {display: 'inline', marginLeft: '0.3em', verticalAlign: 'middle'}
                  children: [
                    if @state.player.clan
                      React.DOM.mark style: {margin: '0em 0.2em'}, "#{@state.player.clan.name}"
                    span null, @state.player.lastName
                  ]
                if @state.player.steamUrl and @state.player.steamIcon
                  a {href: @state.player.steamUrl, className: "btn-link"},
                    img
                     src: @state.player.steamIcon
                     style: {verticalAlign: 'middle', margin: '0em 0.3em'}
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
                    if @state.player.chatsPath
                      li
                        className:
                          if @state.player.chatsPath == window.location.pathname
                            'active'
                          else
                            ''
                        children: [
                          a
                            href: @state.player.chatsPath
                            'Chat'
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
                  if @state.player.skill
                    tr null,
                      td null, "Skill"
                      td null, React.createElement(ProgressBar,
                        current: @state.player.skill.points,
                        value: React.createElement(Skill, @state.player.skill),
                        limits: @props.skill_limits)
                  tr null,
                    td null, "Ranking"
                    td null, React.createElement(Ranking, current: @state.player.ranking, total: @props.total)
                  if @state.player.clan
                    tr null,
                      td null, "Clan"
                      td null,
                        a {href: @state.player.clan.path, className: "btn-link"},
                          "#{@state.player.clan.name}"
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
                  if @state.player.activity
                    tr null,
                      td null, "Activity"
                      td null, React.createElement(ProgressBar, current: @state.player.activity, value: "#{@state.player.activity}%")
                  tr null,
                    td null, "ConnectionTime"
                    td null, "#{@state.player.connection_time}".toHHMMSS()
                ]
          ]
      ]
  componentWillMount: ->
    @serverRequest = $.get @props.url, (data) =>
      @setState player: data
      @refs.header.setState player: data



module.exports.Player = Player
module.exports.PlayerHeader = PlayerHeader
