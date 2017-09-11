$(document).on('change', '#user_info_avatar', function() {
  if (this.files && this.files[0]) {
    let reader = new FileReader();
    reader.onload = (e) => {
      $('.upload-preview').find('.profile-image-thumbnail').attr('src', e.target.result);
      $('.upload-preview').find('.profile-image-full').attr('src', e.target.result);
    }
    reader.readAsDataURL(this.files[0]);
  } else {
    let default_profile_image = $(this).data('default-profile-image');
    $('.upload-preview').find('.profile-image-thumbnail').attr('src', default_profile_image);
    $('.upload-preview').find('.profile-image-full').attr('src', default_profile_image);
  }
});
