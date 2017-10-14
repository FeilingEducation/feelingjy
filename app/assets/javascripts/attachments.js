'use strict';

// setup for attachments at load
// jquery-file-upload (https://github.com/blueimp/jQuery-File-Upload) is used
// to upload attachments (source in /vendor/assets/javascripts/jquery.fileupload.js).
// The .fileupload() function is the entry point
//
// See
// https://github.com/blueimp/jQuery-File-Upload/wiki/Setup
// and
// https://github.com/blueimp/jQuery-File-Upload/wiki/Basic-plugin
//
// After setup, any file upload through .attachments-input will append an element
// to the .attachments-container with a progress bar, and once the upload is done,
// the progress bar is removed.
//
// Currently only used with messages.
$(document).on('turbolinks:load', function () {
  // use "count" to identify each uploaded file
  $('.attachments-input').data('count', 0);
  $('.attachments-input').fileupload({
    // trigger when upload finished
    // data is returned from the backend. See attachments_controller#create when it
    // responds to JSON format
    done: function done(e, data) {
      var $attachment = $("#attachment-" + data.id);
      $attachment.data('result', data.result.files[0]);
      // used to tell the backend what attachments are associated with a message.
      // See messages_controller#create
      $attachment.append($('<input type="hidden" name="attachment_ids[]" value="' + data.result.files[0].id + '">'));
      $attachment.find('.attachment-progress').remove();
    }
  }).bind('fileuploadadd', function (e, data) {
    // trigger when upload initiated
    var count = $(this).data('count');
    // this "data" object is persisted through the sequence of events
    // so the data.id would be used in the "done" callback to append the hidden
    // input to the appropriate attachment element
    data.id = count;
    // Append an attachment element to the attachments-container
    // the icon .attachment-remove is clickable and will remove this attachment
    // from both front and back end.
    $(this).closest('.form-group').find('.attachments-container').append($(' <div id="attachment-' + count + '" class="attachment">' + '   <span class="attachment-name">' + data.files[0].name + '</span>' + '   <div class="attachment-progress"><div class="bar"></div></div>' + '   <i class="fa fa-times attachment-remove"></i>' + ' </div>'));
    $(this).data('count', count + 1);
  }).bind('fileuploadprogress', function (e, data) {
    // update the progress bar. See jquery-file-upload official documents for more information.
    $('.attachment-progress bar').css('width', parseInt(data.loaded / data.total * 100, 10).toString() + "%");
  });
});

// when the "times" icon on the attachment element is clicked, an ajax request is
// sent to backend to remove it. When the request completes successfully, the frontend
// element is also removed.
// See attachments_controller#destroy
$(document).on('click', '.attachment-remove', function () {
  var $attachment = $(this).closest('.attachment');
  $.ajax({
    url: $attachment.data('result').delete_url,
    type: 'POST',
    dataType: 'json',
    data: { "_method": "DELETE" }
  }).done(function (data) {
    $attachment.remove();
  });
});
