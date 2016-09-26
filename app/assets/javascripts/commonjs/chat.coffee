{img, span, a, small, mark} = React.DOM
ReactBSTable = require('react-bootstrap-table')
BootstrapTable = ReactBSTable.BootstrapTable
TableHeaderColumn = ReactBSTable.TableHeaderColumn

ChatTable = React.createClass

  getData: ->
    if @props.url
      full_url = @props.url
      full_url += "&offset=#{(@state.page - 1) * @state.size_per_page}"
      full_url += "&limit=#{@state.size_per_page}"
      console.log full_url
      @serverRequest = $.get full_url, (data) =>
        @setState response: data

  onPageChange: (page, size_per_page) ->
    new_uri = updateQueryStringParameter(updateQueryStringParameter(window.location.href, 'page', page), 'limit', size_per_page)
    history.pushState { url: new_uri }, 'title', new_uri
    @setState page: page, size_per_page: size_per_page

  onSizePerPageList: (size_per_page) ->
    new_uri = updateQueryStringParameter(window.location.href, 'limit', size_per_page)
    history.pushState { url: new_uri }, 'title', new_uri
    @setState size_per_page: size_per_page

  componentDidUpdate: (prevProps, prevState) ->
    if prevState.page != @state.page or prevState.size_per_page != @state.size_per_page
      @getData()

  componentDidMount: ->
    @getData()

  getInitialState: ->
    response:
      rows: []
      total: 0
    page: 1
    size_per_page: @props.size_per_page

  playerNameFormatter: (cell, row) ->

    a
      href: cell.pathname
      children: [
        if cell.avatarIcon
          img {src: cell.avatarIcon, width: '30px', height: '30px'}
        if cell.avatarIcon
          " "
        if cell.clan
          small {},
            mark {},
              cell.clan.name
        if cell.clan
          " "
        cell.lastName
      ]

  serverNameFormatter: (cell, row) ->
    cell.name

  render: ->
    console.log("123123")
    console.log @props.url
    console.log @state.response
    React.createElement(BootstrapTable,
      data: @state.response.rows
      condensed: true
      remote: true
      pagination: true
      fetchInfo: {dataTotalSize: @state.response.total}
      options: {
        defaultSortName: 'eventTime',
        defaultSortOrder: 'desc'
        sizePerPage: @state.size_per_page,
        onPageChange: @onPageChange,
        sizePerPageList: [10, 25, 50, 100],
        onSortChange: @onSortChange,
        pageStartIndex: 1,
        page: @state.page,
        onSizePerPageList: @onSizePerPageList
      },
      children: [
        React.createElement(TableHeaderColumn, {
            dataField: 'player'
            dataFormat: @playerNameFormatter
            key: 'player'
            width: '200px'
            isKey: true
          }
          'Player')
        React.createElement(TableHeaderColumn, {
            dataField: 'message'
            key: 'message'
            width: '600px'
          }
          'Message')
        React.createElement(TableHeaderColumn, {
            dataField: 'eventTime'
            key: 'eventTime'
            width: '150px'
          }
          'Time')
        React.createElement(TableHeaderColumn, {
            dataField: 'map'
            key: 'map'
            width: '150px'
          }
          'Map')
        React.createElement(TableHeaderColumn, {
            dataField: 'server'
            width: '300px'
            dataFormat: @serverNameFormatter
            key: 'server'
          }
          'Server')
      ]
    )

module.exports.ChatTable = ChatTable
