'use strict';

// navigate through multi-step-form
$(document).on('click', '.multi-step-form .step-navigate', function () {
  var $this = $(this);
  if ($this.is('.submit')) {
    $this.closest('form').submit();
    return;
  }
  var $curr_form = $this.closest('.multi-step-form');
  var $target_form = $($this.data('target'));
  $curr_form.toggleClass('current-step');
  $target_form.toggleClass('current-step');
  $target_form.find('input, select').filter(':first').focus();
});
