// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require_tree .

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

function isObject(obj) {
  return obj === Object(obj);
}

// handle custom file inputs
$(document).on('change', '.custom-file input[type="file"]', function () {

  const $input = $(this);
  const target = $input.data('target');
  const $target = $(target);

  if (!$target.length)
    return console.error('Invalid target for custom file', $input);

  if (!$target.attr('data-content'))
    return console.error('Invalid `data-content` for custom file target', $input);

  // set original content so we can revert if user deselects file
  if (!$target.attr('data-original-content'))
    $target.attr('data-original-content', $target.attr('data-content'));

  const input = $input.get(0);

  let name = isObject(input) && isObject(input.files) && isObject(input.files[0])
    && typeof input.files[0].name === "string" ? input.files[0].name : $input.val();

  if (!name)
    name = $target.attr('data-original-content');

  $target.attr('data-content', name);

});
