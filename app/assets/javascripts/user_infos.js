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

$(document).on('turbolinks:load', function () {
  // $( ".select2" ).select2({})
  $.map($(".select2"), function(select2, idx){
    if($(select2).hasClass('state')){
      console.log('has class state...')
      $(select2).select2({}).on('change', function(e){
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
    }
    else if($(select2).hasClass('country')){
      console.log('has class country...')
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
    }
    else{
      $(select2).select2({})
    }
  })
})


$(document).on('click', '#transaction-tracking-item0', function () {
  var item1 = document.getElementById("transaction-tracking-item1");
  item1.classList.remove('active');
  var item2 = document.getElementById("transaction-tracking-item2");
  item2.classList.remove('active');

  var item0 = document.getElementById("transaction-tracking-item0");
  item0.className += " active";


  var current_tutors = document.getElementById("current-tutors");
  current_tutors.className += " d-none";

  var previous_tutors = document.getElementById("previous-tutors");
  previous_tutors.className += " d-none";

  var all_tutors = document.getElementById("all-tutors");
  all_tutors.classList.remove('d-none');
});

$(document).on('click', '#transaction-tracking-item1', function () {
  var item0 = document.getElementById("transaction-tracking-item0");
  item0.classList.remove('active');
  var item2 = document.getElementById("transaction-tracking-item2");
  item2.classList.remove('active');

  var item1 = document.getElementById("transaction-tracking-item1");
  item1.className += " active";

  var all_tutors = document.getElementById("all-tutors");
  all_tutors.className += " d-none";

  var previous_tutors = document.getElementById("previous-tutors");
  previous_tutors.className += " d-none";

  var current_tutors = document.getElementById("current-tutors");
  current_tutors.classList.remove('d-none');

});

$(document).on('click', '#transaction-tracking-item2', function () {
  var item1 = document.getElementById("transaction-tracking-item1");
  item1.classList.remove('active');
  var item0 = document.getElementById("transaction-tracking-item0");
  item0.classList.remove('active');

  var item2 = document.getElementById("transaction-tracking-item2");
  item2.className += " active";

  var all_tutors = document.getElementById("all-tutors");
  all_tutors.className += " d-none";

  var current_tutors = document.getElementById("current-tutors");
  current_tutors.className += " d-none";

  var previous_tutors = document.getElementById("previous-tutors");
  previous_tutors.classList.remove('d-none');

});
