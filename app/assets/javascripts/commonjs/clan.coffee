ReactBSTable = require('react-bootstrap-table')
BootstrapTable = ReactBSTable.BootstrapTable
TableHeaderColumn = ReactBSTable.TableHeaderColumn

ClanTable = React.createClass

  getData: ->
    if @props.url
      full_url = @props.url
      full_url += "?offset=#{(@state.page - 1) * @state.size_per_page}"
      full_url += "&limit=#{@state.size_per_page}"
      full_url += "&sort=#{@state.sort_name}"
      full_url += "&order=#{@state.sort_order}"
      full_url += "&members=#{@props.members}"
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

  onSortChange: (sort_name, sort_order) ->
    new_uri = updateQueryStringParameter(updateQueryStringParameter(window.location.href, 'sort', sort_name), 'order', sort_order)
    history.pushState { url: new_uri }, 'title', new_uri
    @setState sort_name: sort_name, sort_order: sort_order

  componentDidUpdate: (prevProps, prevState) ->
    if prevState.page != @state.page or prevState.size_per_page != @state.size_per_page or @state.sort_name != prevState.sort_name or @state.sort_order != prevState.sort_order
      @getData()

  componentDidMount: ->
    @getData()

  getInitialState: ->
    response:
      rows: []
      total: 0
    page: 1
    members: 3
    size_per_page: @props.size_per_page
    sort_name: @props.sort
    sort_order: @props.order

  tagNameFormatter: (cell, row) ->
    React.DOM.a {href: row.path}, row.tag

  render: ->
    React.createElement(BootstrapTable,
      data: @state.response.rows
      remote: true
      pagination: true
      fetchInfo: {dataTotalSize: @state.response.total}
      options: {
        defaultSortName: 'skill',
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
            dataField: 'tag'
            key: 'tag'
            dataFormat: @tagNameFormatter
            dataSort: true
            isKey: true
          }
          'Tag')
        React.createElement(TableHeaderColumn, {
            dataField: 'members'
            key: 'members'
            dataSort: true
          }
          'Members')
        React.createElement(TableHeaderColumn, {
            dataField: 'skill'
            key: 'skill'
            dataSort: true
          }
          'Skill')
        React.createElement(TableHeaderColumn, {
            dataField: 'kills'
            key: 'kills'
            dataSort: true
          }
          'Kills')
      ]
    )

module.exports.ClanTable = ClanTable
