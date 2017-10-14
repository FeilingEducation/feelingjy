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
