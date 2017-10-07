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
//= require jquery.ui.widget
//= require jquery.fileupload
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('.attachments-input').data('count', 0);
  $('.attachments-input').fileupload({
    done: function(e, data) {
      const $attachment = $(`#attachment-${data.id}`);
      $attachment.data('result', data.result.files[0]);
      $attachment.append($(`<input type="hidden" name="attachment_ids[]" value="${data.result.files[0].id}">`));
      $attachment.find('.attachment-progress').remove();
    }
  }).bind('fileuploadadd', function(e, data) {
    const count = $(this).data('count');
    data.id = count;
    $(this).closest('.form-group').find('.attachments-container').append($(
      ` <div id="attachment-${count}" class="attachment">` +
      `   <span class="attachment-name">${data.files[0].name}</span>` +
      `   <div class="attachment-progress"><div class="bar""></div></div>` +
      `   <i class="fa fa-times attachment-remove"></i>` +
      ` </div>`
    ));
    $(this).data('count', count+1);
  }).bind('fileuploadprogress', function(e, data) {
    $('.attachment-progress bar').css('width', `${parseInt(data.loaded/data.total*100,10)}%`);
  });
});

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

  const name = (isObject(input) && isObject(input.files) && isObject(input.files[0])
    && typeof input.files[0].name === "string" ? input.files[0].name : $input.val())
    || $target.attr('data-original-content');

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

function custom_file_input(name, classes, accept) {
  return `<div class="custom-file ${classes}" >` +
        `   <input type="file" name="${name}" class="custom-file-input image-input"` +
        `     data-target="#filename-span" accept="${accept}">` +
        `   <span id="filename-span" class="custom-file-control custom-file-name" data-content="请选择文件..."></span>` +
        ` </div>`;
}

function dynamic_modal(body, title, size) {
  title = title || '';
  size = size == 'large' ? 'lg' : 'sm';
  const $dialog = $('#dialog');
  $dialog.find('.modal-title').html(title);
  $dialog.find('.modal-dialog').removeClass('modal-sm').removeClass('modal-lg').addClass(`modal-${size}`);
  $dialog.find('.modal-body').empty().append(body);
  show_or_update($dialog);
}

$(document).on('click', '.editable', function() {
  const $this = $(this);
  const scoped_name = $this.data('scope') ? `${$this.data('scope')}[${$this.data('name')}]` : $this.data('name');
  const $form = $('#template-form').clone().removeAttr('id').css('display', 'block');
  if ($this.data('action')) {
    $form.attr('action', $this.data('action'));
  }
  let value = '';
  if ($this.data('value')) {
    value = $this.value;
  } else if ($this.data('target')) {
    const $target = $this.find($this.data('target'));
    if ($this.data('attr')) {
      value = $target.attr($this.data('attr'));
    } else {
      value = $target.text();
    }
  }
  switch($this.data('type')) {
    case 'image':
      $form.attr('enctype', 'multipart/form-data');
      $form.append($(`<img id="preview" class="editable-image-preview mb-3" src="${value}">`));
      var $file_input = $(custom_file_input(scoped_name, 'mb-3', 'image/*'));
      $file_input.find('input').data('image-input-target', '#preview');
      $form.append($file_input);
      break;
    case 'text':
      $form.append($(`<input type="text" name="${scoped_name}" class="form-control mb-3 autofocus autoselect" value="${value}">`));
      break;
    case 'paragraph':
      $form.append($(`<textarea name="${scoped_name}" class="form-control mb-3  autofocus autoselect" rows="10" style="resize:none">`).val(value));
      break;
    case 'attachment':
      $form.attr('action', '/attachments');
      $form.attr('enctype', 'multipart/form-data');
      $form.append($(`<input type="hidden" name="${$this.data('scope')}[file_type]" value="${$this.data('file-type')}">`));
      $form.append($(custom_file_input(scoped_name, 'mb-3', 'application/pdf')));
      break;
    default:
      return;
  }
  $form.append($(`<input type="submit" class="btn btn-success float-right mb-3" value="保存">`));
  dynamic_modal($form, $this.data('label'), $this.data('size'));
});

$(document).on('shown.bs.modal', '#dialog', function() {
  $(this).find('.autofocus').focus();
  $(this).find('.autoselect').select();
});

$(document).on('click', '.modal-toggle', function() {
  show_or_update($($(this).data('target')))
});

function sanitize(html) {
  return html.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
}

$(document).on('click', '.attachment-remove', function() {
  const $attachment = $(this).closest('.attachment');
  $.ajax({
    url: $attachment.data('result').delete_url,
    type: 'POST',
    dataType: 'json',
    data: {"_method": "DELETE"}
  }).done(function(data) {
    $attachment.remove();
  });
});

$(document).on('ajax:success', '.message-form', function(e) {
  const data = e.detail[0];
  const $this = $(this);
  const $history = $('.message-history');
  $history.append($(
    `<div class="message">` +
    ` <span class="fs-120 d-block"><strong>${data.sender}</strong></span>` +
    ` <span class="fs-80 d-block">Posted on: ${data.timestamp}</span>` +
    ` <p class="mb-1">${data.content}</p>` +
    data.attachments.reduce((cat, att) => {
      return cat +
        `<div class="attachment">` +
        ` <a href="${att.url}" target="_blank">${att.name}</a>` +
        `</div>`;
    }, '') +
    `</div>`
  )).prop('scrollTop', $history.prop('scrollHeight'));
  $this.find('.attachments-container').empty();
});
