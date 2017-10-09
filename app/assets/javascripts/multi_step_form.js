// navigate through multi-step-form
$(document).on('click', '.multi-step-form .step-navigate', function() {
  const $this = $(this);
  if ($this.is('.submit')) {
    $this.closest('form').submit();
    return;
  }
  const $curr_form = $this.closest('.multi-step-form');
  const $target_form = $($this.data('target'));
  $curr_form.toggleClass('current-step');
  $target_form.toggleClass('current-step');
  $target_form.find('input, select').filter(':first').focus();
});
