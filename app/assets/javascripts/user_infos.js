'use strict';

// image preview for user_info avatar change
// Only used in /views/user_infos/new.html.erb and no existing link to that page
// Could be replaced by .image-input (See application.js)
$(document).on('change', '#user_info_avatar', function () {
  if (this.files && this.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('.upload-preview').find('.profile-image-thumbnail').attr('src', e.target.result);
      $('.upload-preview').find('.profile-image-full').attr('src', e.target.result);
    };
    reader.readAsDataURL(this.files[0]);
  } else {
    var default_profile_image = $(this).data('default-profile-image');
    $('.upload-preview').find('.profile-image-thumbnail').attr('src', default_profile_image);
    $('.upload-preview').find('.profile-image-full').attr('src', default_profile_image);
  }
});
$(document).ready(function(){
  $( ".select2" ).select2({})
  $( ".select2.state" ).select2({}).on('change', function(e){
    $.ajax({
      url: '/instructor/cities.json?state=' + e.target.value + "&country="+ $('.select2.country').val(),
      dataType: 'json',
      success: function (resp) {
        console.log("resp", resp)
        $( ".select2.city" ).empty()
        $( ".select2.city" ).select2({})
        $.map(resp, function(key, val){
          var option = new Option(key, val);
          $( ".select2.city" ).append(option);
        })
        // $( ".select2.state" ).trigger("change");
      }
    });
  })
  $( ".select2.city" ).select2({})

  $('.select2.country').select2({}).on('change', function(e){
    console.log('change....', e.target.value)
    $.ajax({
      url: '/instructor/states.json?country=' + e.target.value,
      dataType: 'json',
      success: function (resp) {
        console.log("resp", resp)
        $( ".select2.state" ).empty()
        $( ".select2.state" ).select2({})
        $.map(resp, function(key, val){
          var option = new Option(key, val);
          $( ".select2.state" ).append(option);
        })
        // $( ".select2.state" ).trigger("change");
      }
    });
  })
})
