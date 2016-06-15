ReactBSTable = require('react-bootstrap-table')
BootstrapTable = ReactBSTable.BootstrapTable
TableHeaderColumn = ReactBSTable.TableHeaderColumn

ClanTable = React.createClass

  getData: ->
    if @props.url
      console.log @state.page
      full_url = @props.url
      full_url += "?offset=#{(@state.page - 1) * @state.size_per_page}"
      full_url += "&limit=#{@state.size_per_page}"
      full_url += "&sort=#{@state.sort_name}"
      full_url += "&order=#{@state.sort_order}"
      console.log full_url
      @serverRequest = $.get full_url, (data) =>
        @setState response: data

  onPageChange: (page, size_per_page) ->
    @setState page: page, size_per_page: size_per_page

  onSizePerPageList: (size_per_page) ->
    @setState size_per_page: size_per_page

  onSortChange: (sort_name, sort_order) ->
    console.log sort_name
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
    size_per_page: 25
    sort_name: 'skill'
    sort_order: 'desc'

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
