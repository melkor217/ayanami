{a, div} = React.DOM

FBWidget = React.createClass
  getDefaultProps: ->
    path: '/'
  render: ->
    div
      className: 'fb-share-button'
      style: {verticalAlign: 'middle', margin: '0em 2em', display: 'inline-flex'}
      'data-href': @props.path
      'data-layout': 'button_count'


module.exports.FBWidget = FBWidget
