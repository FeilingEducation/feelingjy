$(document).on('turbolinks:load', function () {
  $('.rating').raty('destroy')
  $('.rating').raty({readOnly: true})
  $(function(){
  $('.close').click(function(){
    $('iframe').attr('src', $('iframe').attr('src'));
  });
  });
});
