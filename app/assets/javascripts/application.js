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
//= require bootstrap-slider
//= require bootstrap-multiselect
//= require components
//= require turbolinks
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

(function($){
  $.fn.getFormData = function() {
    return $(this).serializeArray().reduce(function (obj, item) {
      if (obj[item.name]) {
        if ($.isArray(obj[item.name])) {
          obj[item.name].push(item.value);
        } else {
          var previousValue = obj[item.name];
          obj[item.name] = [previousValue, item.value];
        }
      } else {
        obj[item.name] = item.value;
      }
      return obj;
    }, {});
  };
})(jQuery);

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

$(document).on('keypress', function(e) {
  if (e.keyCode !== 13) {
    return;
  }
  if ($(e.target).is('body, input[type="text"]')) {
    // need to do validation here
    $('.current-step .main-btn').click();
  }
});

$.fn.textWidth = function(text, font) {
  if (!$.fn.textWidth.helper)
    $.fn.textWidth.helper = $('<pre>').css({visibility: "hidden", display: "inline"});
  if ($.fn.textWidth.helper.parent()[0] !== document.body)
    $.fn.textWidth.helper.appendTo(document.body);
  $.fn.textWidth.helper.text(text || this.val() || this.text() || this.attr('placeholder'))
  .css('font', font || this.css('font'));
  return $.fn.textWidth.helper.width();
}

$(document).on('change', '.image-input', function() {
  const $this = $(this);
  if (this.files && this.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $($this.data('image-input-target')).attr('src', e.target.result);
    }
    reader.readAsDataURL(this.files[0]);
  }
});

function custom_image_input(name, target, classes) {
  return `<div class="custom-file ${classes}" >` +
        `   <input type="file" name="${name}" class="custom-file-input image-input"` +
        `     data-image-input-target="${target}" data-target="#filename-span" accept="image/*">` +
        `   <span id="filename-span" class="custom-file-control custom-file-name" data-content="请选择文件..."></span>` +
        ` </div>`;
}

$(document).on('click', '.editable', function() {
  const $this = $(this);
  const name = $this.data('name');
  const action = $this.data('action');
  let $dialog = $('#dialog');
  let $form = $('#template-form').clone().removeAttr('id').css('display', 'block');
  if ($this.data('action')) {
    $form.attr('action', $this.data('action'));
  }
  if ($this.data('size') == 'large') {
    $('#dialog .modal-dialog').removeClass('modal-sm').addClass('modal-lg');
  } else {
    $('#dialog .modal-dialog').removeClass('modal-lg').addClass('modal-sm');
  }
  let $text;
  switch($this.data('type')) {
    case 'image':
      $img = $this.find('img');
      $dialog.find('.modal-title').html($img.prop('alt'));
      $form.attr('enctype', 'multipart/form-data');
      $form.append($(`<img id="preview" class="editable-image-preview mb-3" src="${$img.prop('src')}">`));
      $form.append($(custom_image_input(name, '#preview', 'mb-3')));
      break;
    case 'textfield':
      $dialog.find('.modal-title').html($this.data('label'));
      $text = $this.find('span');
      $form.append($(`<input type="text" name="${$this.data('name')}" class="form-control mb-3 autofocus autoselect" value="${$text.html()}">`));
      break;
    case 'textarea':
      $dialog.find('.modal-title').html($this.data('label'));
      $text = $this.find('p');
      $form.append($(`<textarea name="${$this.data('name')}" class="form-control mb-3  autofocus autoselect" rows="10" style="resize:none">`).val($text.text()));
      break;
    default:
      return;
  }
  $form.append($(`<input type="submit" class="btn btn-success float-right mb-3" value="保存">`));
  $dialog.find('.modal-body').empty().append($form);
  show_or_update($dialog);
});

$(document).on('shown.bs.modal', '#dialog', function() {
  $(this).find('.autofocus').focus();
  $(this).find('.autoselect').select();
});

$(document).on('turbolinks:load', function() {
  $('input[type="text"].convertible').trigger('input');
})

function sanitize(html) {
  return html.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
}
