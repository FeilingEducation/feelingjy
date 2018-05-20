// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('turbolinks:load', function () {

  $("li.pay-elem").on('click', function(){
    var id = $(this).data("attr")
    $(".right-wrapper").addClass("hidden")
    $(id).removeClass("hidden")
    $(".pay-elem").removeClass("active")
    $(this).addClass("active")
  })

})
