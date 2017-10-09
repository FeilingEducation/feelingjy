
// If the modal is already shown, we update it. Otherwise showing it twice makes
// it un-closable.
function show_or_update(modal) {
  if ((modal.data('bs.modal') || {_isShown: false})._isShown) {
    modal.modal("handleUpdate");
    modal.find(".first_input").focus();
  } else {
    modal.modal("show");
    modal.on("shown.bs.modal", function() {
      modal.find(".first-input").focus();
    });
  }
}

// show a modal given the body, title, and size
// The modal template is rendered hidden at the bottom of the page
// See /views/layouts/application.html.erb and /views/application/_dialog.html.erb
function dynamic_modal(body, title, size) {
  title = title || '';
  size = size == 'large' ? 'lg' : 'sm';
  const $dialog = $('#dialog');
  $dialog.find('.modal-title').html(title);
  $dialog.find('.modal-dialog').removeClass('modal-sm').removeClass('modal-lg').addClass(`modal-${size}`);
  $dialog.find('.modal-body').empty().append(body);
  show_or_update($dialog);
}

$(document).on('shown.bs.modal', '#dialog', function() {
  $(this).find('.autofocus').focus();
  $(this).find('.autoselect').select();
});

// show a modal identified by the data-target
$(document).on('click', '.modal-toggle', function() {
  show_or_update($($(this).data('target')))
});
