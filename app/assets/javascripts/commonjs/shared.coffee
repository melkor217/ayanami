Skill = React.createClass
  getDefaultProps: ->
    points: 1000
    last_change: 0
  render: ->
    {div, small} = React.DOM
    sign = if @props.last_change > 0 then '+' else ''
    color = if @props.last_change < 0 then 'text-danger' else 'text-success'
    div null, "#{@props.points} ",
      small
        className: color,
        "(#{sign}#{@props.last_change})"

Ranking = React.createClass
  getDefaultProps: ->
    current: 1
    total: 1
  render: ->
    React.DOM.span null,
      "#{@props.current} of #{@props.total} (#{Math.round(100 * (100 - 100 * (@props.current * 1.0 - 1) / @props.total)) / 100}%)"

ProgressBar = React.createClass
  getDefaultProps: ->
    limits:
      min: 0
      max: 100
    current: 0 # raw value
    value: 0 # formatted value for printing
  render: ->
    {span, div} = React.DOM
    percent = 100 * (@props.current - @props.limits.min) / (@props.limits.max - @props.limits.min)
    div
      className: 'progressbar-container'
      children: [
        div
          className: 'progress'
          children: [
            div
              className: "progress-bar progress-bar-info",
              role: "progressbar"
              'aria-valuemin': @props.limits.min
              'aria-valuemax': @props.limits.max
              'aria-valuenow': @props.current
              style: {width: "#{percent}%"}
              children: [
                span null, @props.value
              ]
          ]
      ]

module.exports.ProgressBar = ProgressBar
module.exports.Ranking = Ranking
module.exports.Skill = Skill
