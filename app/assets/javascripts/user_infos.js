$(document).on('change', '#user_info_avatar', function() {
  if (this.files && this.files[0]) {
    let reader = new FileReader();
    reader.onload = (e) => {
      $('.upload-preview').find('.profile-image-thumbnail').attr('src', e.target.result);
      $('.upload-preview').find('.profile-image-full').attr('src', e.target.result);
    }
    reader.readAsDataURL(this.files[0]);
  } else {
    $('.upload-preview').find('.profile-image-thumbnail').attr('src', default_profile.png);
    $('.upload-preview').find('.profile-image-full').attr('src', default_profile.png);
  }
});

$(document).on('ajax:success', '.current-form', function() {
  const $this = $(this);
  const $next_form = $($this.data('next-form'));
  $this.toggleClass('current-form');
  $next_form.toggleClass('current-form');
});
