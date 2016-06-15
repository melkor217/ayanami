ReactBSTable = require('react-bootstrap-table')
BootstrapTable = ReactBSTable.BootstrapTable
TableHeaderColumn = ReactBSTable.TableHeaderColumn

ClanTable = React.createClass

  getData: ->
    if @props.url
      console.log @state.page
      full_url = "#{@props.url}?offset=#{(@state.page - 1) * @state.size_per_page}&limit=#{@state.size_per_page}"
      @serverRequest = $.get full_url, (data) =>
        @setState response: data

  onPageChange: (page, size_per_page) ->
    @setState page: page, size_per_page: size_per_page

  onSizePerPageList: (size_per_page) ->
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
    size_per_page: 25

  render: ->
    React.createElement(BootstrapTable,
      data: @state.response.rows
      remote: true
      pagination: true
      fetchInfo: {dataTotalSize: @state.response.total}
      options: {
        sizePerPage: @state.size_per_page,
        onPageChange: @onPageChange,
        sizePerPageList: [10, 25, 50, 100],
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
            dataField: 'kills'
            key: 'kills'
            dataSort: true
          }
          'Kills')
      ]
    )

module.exports.ClanTable = ClanTable
