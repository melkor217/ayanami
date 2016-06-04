ReactBSTable = require('react-bootstrap-table')
BootstrapTable = ReactBSTable.BootstrapTable
TableHeaderColumn = ReactBSTable.TableHeaderColumn
{a, img} = React.DOM

WeaponTable = React.createClass
  componentDidMount: ->
    if @props.url
      @serverRequest = $.get @props.url, (data) =>
        console.log data
        @setState response: data
  getInitialState: ->
    response:
      rows: []
  getDefaultProps: ->
    url: null
    sum: 0
  weaponNameFormatter: (cell, row) ->
    a
      href: row.path
      children: [
        img
          src: row.icon
          alt: row.name
        row.name
      ]
  render: ->
    React.createElement(BootstrapTable, data: @state.response.rows, children: [
      React.createElement(TableHeaderColumn,
        {
          dataField: 'name'
          key: 'name'
          isKey: true
          dataFormat: @weaponNameFormatter
          dataSortable: true
          dataSort: true
        }
        'Weapon')
      React.createElement(TableHeaderColumn, {
          dataField: 'kills'
          key: 'kills'
          dataSort: true
        }
        'Kills')
      React.createElement(TableHeaderColumn, {
          dataField: 'headshots'
          key: 'headshots'
          dataSort: true
        }
        'Headshots')
      React.createElement(TableHeaderColumn, {
          dataField: 'modifier'
          key: 'modifier'
          dataSort: true
        }
        'Modifier')
    ])


module.exports.WeaponTable = WeaponTable
