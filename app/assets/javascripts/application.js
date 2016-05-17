// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-table
//= require bootstrap-table-fixed-columns
//= require_tree .

String.prototype.toHHMMSS = function () {
    var sec_num = parseInt(this, 10); // don't forget the second param
    var hours   = Math.floor(sec_num / 3600);
    var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
    var seconds = sec_num - (hours * 3600) - (minutes * 60);

    if (hours   < 10) {hours   = "0"+hours;}
    if (minutes < 10) {minutes = "0"+minutes;}
    if (seconds < 10) {seconds = "0"+seconds;}
    return hours+':'+minutes+':'+seconds;
}

var getQueryParam = function(param) {
    // http://test.url/page.html?param=a&b=c
    // ->
    // param
    var found;
    window.location.search.substr(1).split("&").forEach(function(item) {
        if (param ==  item.split("=")[0]) {
            found = item.split("=")[1];
        }
    });
    return found;
};

function runningFormatter(value, row, index) {
    // Position formatter for tables
    //if (getQueryParam('page') && getQueryParam('limit')) {
    //    return index + 1 + (getQueryParam('page') -1 )*getQueryParam('limit');
    //}
    //else {
    return index + 1;
    //}
}

function urlFormatter(value, row, index) {
    return '<a class="btn-link" href="' + row.path + '">' + row.lastName + '</a>';
}

function countryFormatter(value, row, index) {
    return '<a class="btn-link" href="' + row.path + '">' + row.country + '</a>';
}

function flagFormatter(value, row, index) {
    return '<a class="btn-link" href="' + row.path + '"><img src="' + row.icon + '" width="32" height="32" alt="' + value + '"/>('+value+')</a>';
}

function weaponFormatter(value, row, index) {
    return '<a class="btn-link" href="' + row.path + '">' + row.name + '</a>';
}

function skillFormatter(value, row, index) {
    var sign = value.last_change>0?'+':'';
    var color_class = value.last_change>=0?'text-success':'text-danger';
    return value.points + ' <small><span class="' + color_class + '">(' + sign + value.last_change + ')</span></small>';
}

function activityFormatter(value, row, index) {
    // css is stewpid -_-
    return '<div style="vertical-align: center;overflow: hidden; height: 20px;">' +
        '<div class="progress"><div role="progressbar" ' +
        'class="progress-bar progress-bar-info" aria-valuemin="0" aria-valuemax="100" aria-valuenow="' +
        value.toString() + '" style="width:' + value.toString() + '%; height: 20px;"><span>' +
        value.toString() + '%</span></div></div></div>';
}

function timeFormatter(value, row, index) {
    return value.toString().toHHMMSS();
}

$(window).unload(function (e) {
    e.preventDefault();
    alert("Back was pressed!");
});

function updateQueryStringParameter(uri, key, value) {
    // http://uri.com/page?key=old
    // ->
    // http://uri.com/page?key=value
    //
    // http://uri.com/page?qwe=123
    // ->
    // http://uri.com/page?qwe=123&key=value


    var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
    var separator = uri.indexOf('?') !== -1 ? "&" : "?";
    if (uri.match(re)) {
        uri = uri.replace(re, '$1' + key + "=" + value + '$2');
    }
    else {
        uri = uri + separator + key + "=" + value;
    }
    return uri.replace(/[^=&]+=(&|$)/g, "").replace(/&$/, "");
}


$(function () {
    var $result = $('#eventsResult');

    $('#table').on('all.bs.table', function (e, name, args) {
        console.log('Event:', name, ', data:', args);
    })
    //.on('click-row.bs.table', function (e, row, $element) {
    //    Turbolinks.visit(row["path"]);
    //    $result.text('Event: click-row.bs.table');
    //})
        .on('dbl-click-row.bs.table', function (e, row, $element) {
            $result.text('Event: dbl-click-row.bs.table');
        })
        .on('sort.bs.table', function (e, name, order) {
            history.pushState({
                turbolinks: true,
                url: window.location.href
            }, "new title", updateQueryStringParameter(updateQueryStringParameter(window.location.href, 'sort', name), 'order', order));
            $(window).scrollTop(0);
            $result.text('Event: sort.bs.table');
        })
        .on('check.bs.table', function (e, row) {
            $result.text('Event: check.bs.table');
        })
        .on('uncheck.bs.table', function (e, row) {
            $result.text('Event: uncheck.bs.table');
        })
        .on('check-all.bs.table', function (e) {
            $result.text('Event: check-all.bs.table');
        })
        .on('uncheck-all.bs.table', function (e) {
            $result.text('Event: uncheck-all.bs.table');
        })
        .on('load-success.bs.table', function (e, data) {
            $result.text('Event: load-success.bs.table');
        })
        .on('load-error.bs.table', function (e, status) {
            $result.text('Event: load-error.bs.table');
        })
        .on('column-switch.bs.table', function (e, field, checked) {
            $result.text('Event: column-switch.bs.table');
        })
        .on('page-change.bs.table', function (e, number, size) {
            //history.pushState("object or string representing the state of the page", "new title", window.location+"?page="+number+'&limit='+size);
            //history.pushState("object or string representing the state of the page", "new title", window.location+"?page="+number+'&limit='+size);
            history.pushState({
                turbolinks: true,
                url: window.location.href
            }, "new title", updateQueryStringParameter(updateQueryStringParameter(window.location.href, 'page', number), 'limit', size));
            $(window).scrollTop(0);
            $result.text('Event: page-change.bs.table');
        })
        .on('search.bs.table', function (e, text) {
            history.pushState({
                turbolinks: true,
                url: window.location.href
            }, "new title", updateQueryStringParameter(window.location.href, 'search', text));
            $(window).scrollTop(0);
            $result.text('Event: search.bs.table');
        });
});

