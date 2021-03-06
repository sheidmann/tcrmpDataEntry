// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// SH deleted this line because it was requiring double confirmation: = require rails-ujs
// This occurred after adding jquery lines below. StackOverflow suggested to only keep one.

//= require activestorage
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require select2
//= require_tree ../../../vendor/assets/javascripts
//= require_tree .
//= require cocoon

// Set up our EA namespace for our functions
var EA = {};
EA.onRailsPage = function(railsController, railsActions) {
  var selector = _.map(railsActions, function(action) {
    return "body." + railsController + "." + action;
  }).join(', ');

  return $(selector).length > 0;
}

$(function(){
  $('tr[data-link]').click(function(){
    window.location = this.dataset.link
  });

  $('tr[data-link]').hover(
    function(){
      $(this).css("background", "yellow");
      $(this).css("cursor", "pointer");
    },
    function(){
      $(this).css("background", "");
    }
  );
});