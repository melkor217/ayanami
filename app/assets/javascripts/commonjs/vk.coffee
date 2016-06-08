{div} = React.DOM

VKWidget = React.createClass
  getDefaultProps: ->
    elementId: 'vk_like'
    path: '/'
    title: 'Ayanami'
    type: 'mini'
    track: true
  componentDidMount: ->
    if VK and VK._apiId
      VK.Widgets.Like(@props.elementId, {type: @props.type, pageUrl: @props.path, pageTitle: @props.title, pageDescription: @props.title})
      if track
        VK.Observer.subscribe("widgets.like.liked", => ga('send', 'social', 'VK', 'like', @props.path))
        VK.Observer.subscribe("widgets.like.unliked", => ga('send', 'social', 'VK', 'unlike', @props.path))
        VK.Observer.subscribe("widgets.like.shared", => ga('send', 'social', 'VK', 'share', @props.path))
        VK.Observer.subscribe("widgets.like.unshared", => ga('send', 'social', 'VK', 'unshare', @props.path))
  render: ->
    div
      id: @props.elementId
      style: {verticalAlign: 'middle', margin: '0em 2em', display: 'inline-flex'}


module.exports.VKWidget = VKWidget
