@Player = React.createClass
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
  getDefaultProps: ->
    total: 1
    url: ''
    skill_limits:
      min: 0
      max: 2000
  render: ->
    {img, table, tbody, tr, td} = React.DOM
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
          tr null,
            td null, "Kills"
            td null, @state.player.kills
          tr null,
            td null, "Headshots"
            td null, @state.player.headshots
          tr null,
            td null, "Deaths"
            td null, @state.player.deaths
          tr null,
            td null, "K/D"
            td null, Math.round(100 * @state.player.kills / @state.player.deaths) / 100
          tr null,
            td null, "Activity"
            td null, React.createElement(ProgressBar, current: @state.player.activity, value: "#{@state.player.activity}%")
          tr null,
            td null, "ConnectionTime"
            td null, "#{@state.player.connection_time}".toHHMMSS()
        ]

  componentDidMount: ->
    @serverRequest = $.get @props.url, (data) =>
      @setState player: data