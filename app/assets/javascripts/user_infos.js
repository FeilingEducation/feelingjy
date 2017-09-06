$(document).ready(() => {
  $('#user_info_avatar').change(function() {
    if (this.files && this.files[0]) {
      let reader = new FileReader();
      reader.onload = (e) => {
        $('.upload-preview .profile-thumbnail').attr('src', e.target.result);
        $('.upload-preview .profile-full').attr('src', e.target.result);
      }
      reader.readAsDataURL(this.files[0]);
      $('.upload-preview').css('display', 'block')
    } else {
      $('.upload-preview').css('display', 'none')
    }
  });
});
