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

$(document).on('click', '.multi-step-form .step-navigate', function() {
  const $this = $(this);
  const $curr_form = $this.closest('.multi-step-form');
  const $target_form = $($this.data('target'));
  $curr_form.toggleClass('current-step');
  $target_form.toggleClass('current-step');
})

// $(document).on('ajax:success', '.current-form', function() {
//   const $this = $(this);
//   const $next_form = $($this.data('next-form'));
//   $this.toggleClass('current-form');
//   $next_form.toggleClass('current-form');
// });
