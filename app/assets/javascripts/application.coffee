# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require bootstrap-table
#= require bootstrap-table-fixed-columns
#= require react_ujs
#= require components

React = window.React = global.React = require('react')
ReactDOM= window.ReactDOM = global.ReactDOM = require('react-dom')

_ = window._ = global._ = require('commonjs/exports')
#
# ---
# generated by js2coffee 2.2.0
