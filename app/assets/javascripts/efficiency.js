$(document).on('turbolinks:load', function () {
  console.log("Efficiency loaded...")
  $("#degree label").on("click", function(){
    $("#degree label").removeClass("selected")
    $(this).addClass("selected")
  })
  $("#semester label").on("click", function(){
    $("#semester label").removeClass("selected")
    $(this).addClass("selected")
  })
})
