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
//= require jquery
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require bootstrap-slider
//= require bootstrap-multiselect
//= require jquery.ui.widget
//= require jquery.fileupload
//= require select2-full
//= require croppie.min
//= require jquery.raty
//= require turbolinks
//= require_tree .

// convert the formdata into an object
// adapting from multiple answers on https://stackoverflow.com/questions/2276463/how-can-i-get-form-data-with-javascript-jquery
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

// escape some HTML characters to prevent script injection into the page
function sanitize(html) {
  return html.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
}

function isObject(obj) {
  return obj === Object(obj);
}

// handle custom file inputs of bootstrap, which does not update filename on the
// file input when a file is selected.
// adapted from https://github.com/twbs/bootstrap/issues/20813
$(document).on('change', '.custom-file input[type="file"]', function () {

  var $input = $(this);
  var target = $input.data('target');
  var $target = $(target);

  if (!$target.length)
    return console.error('Invalid target for custom file', $input);

  if (!$target.attr('data-content'))
    return console.error('Invalid data-content for custom file target', $input);

  // set original content so we can revert if user deselects file
  if (!$target.attr('data-original-content'))
    $target.attr('data-original-content', $target.attr('data-content'));

  var input = $input.get(0);

  var name = (isObject(input) && isObject(input.files) && isObject(input.files[0])
    && typeof input.files[0].name === "string" ? input.files[0].name : $input.val())
    || $target.attr('data-original-content');

  $target.attr('data-content', name);
});

// .image-input is a special file input, which has an .image-input-target for
// displaying the preview of the selected image before uploading.
$(document).on('change', '.image-input', function() {
  console.log('Change....')
  var $this = $(this);
  if (this.files && this.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      if($this.data('background')){
        $($this.data('target')).css('background', "url("+e.target.result+")");
        $($this.data('target')).addClass('override-background');
      }
      else{
        console.log('background Not found....')
        $($this.data('image-input-target')).attr('src', e.target.result);
      }
    }
    reader.readAsDataURL(this.files[0]);
  }
});

// JS template for a bootstrap custom file input
function custom_file_input(name, classes, accept) {
      return "<div class=\"custom-file " + classes + "\" >" + ("   <input type=\"file\" name=\"" + name + "\" class=\"custom-file-input image-input\"") + ("     data-target=\"#filename-span\" accept=\"" + accept + "\">") + "   <span id=\"filename-span\" class=\"custom-file-control custom-file-name\" data-content=\"请选择文件...\"></span>" + " </div>";
}

// .editable together with "scoped" and "scoped_tree" in /app/helpers/application_helper.rb
// make it possible that an element is displayed on general user side, but will
// prompt a modal for edition on the side of the page owner.
//
// It uses ujs data fields to specify what should the modal prompt look like,
// and what action should be taken when the form inside is submitted.
$(document).on('click', '.editable', function() {
  var $this = $(this);
  // Rails expects model_name[field_name] as the "name" field of a form input for
  // fields with a model.
  var model_name = $this.data('model') ? $this.data('model') + '[' + $this.data('name') + ']' : $this.data('name');
  var token = $('input[name="authenticity_token"][value][value!=""]').attr('value');
  var $form = $('<form accept-charset="UTF-8" method="post">'+
                  '<input name="utf8" type="hidden" value="✓">'+
                  '<input type="hidden" name="authenticity_token" value="'+token+'">'+
                '</form>');
  if ($this.data('action')) {
    $form.attr('action', $this.data('action'));
  }
  // default value of the field in the modal form.
  var value = '';
  if ($this.data('value')) {
    value = $this.value;
  } else if ($this.data('target')) {
    // the target element and its attribute to extract the default value
    var $target = $this.find($this.data('target'));
    if ($this.data('attr')) {
      value = $target.attr($this.data('attr'));
    } else {
      value = $target.text();
    }
  }
  // A hidden field with name "_method" is appended if special method is needed (PATCH, DELETE, etc.)
  if ($this.data('method')) {
    $form.append($('<input type="hidden" name="_method" value="' + $this.data('method') + '">'));
  }
  // construct different types of modal forms
  switch($this.data('type')) {
    // file input for images
    case 'image':
      $form.attr('enctype', 'multipart/form-data');
      // preview selected image without uploading
      $form.append($("<img id=\"preview\" class=\"editable-image-preview 123 mb-3\" src=\"" + value + "\">"));
      var $file_input = $(custom_file_input(model_name, 'mb-3', 'image/*'));
      $file_input.find('input').data('image-input-target', '#preview');
      $form.append($file_input);
      break;
    // text input
    case 'text':
      $form.append($("<input type=\"text\" name=\"" + model_name + "\" class=\"form-control mb-3 autofocus autoselect\" value=\"" + value + "\">"));
      break;
    // paragraph input (use textarea element)
    case 'paragraph':
      $form.append($("<textarea name=\"" + model_name + "\" class=\"form-control mb-3  autofocus autoselect\" rows=\"10\" style=\"resize:none\">").val(value));
      break;
    // PDF files input
    case 'attachment':
      $form.attr('action', '/attachments');
      $form.attr('enctype', 'multipart/form-data');
      $form.append($('<input type="hidden" name="' + $this.data('model') + '[file_type]" value="' + $this.data('file-type') + '">'));
      $form.append($(custom_file_input(model_name, 'mb-3', 'application/pdf')));
      break;
    default:
      return;
  }
  // append the form to the modal and show
  $form.append($("<input type=\"submit\" class=\"btn btn-success float-right mb-3\" value=\"保存\">"));
  dynamic_modal($form, $this.data('label'), $this.data('size'));
});


$(document).on('turbolinks:load', function () {

    // scroll to top feature in instructor profile page
  $(window).scroll(function() {
      if ($(this).scrollTop() >= 200) {        // If page is scrolled more than 50px
          $('#return-to-top').fadeIn(200);    // Fade in the arrow
      } else {
          $('#return-to-top').fadeOut(200);   // Else fade out the arrow
      }
  });
  $('#return-to-top').click(function() {      // When arrow is clicked
      $('body,html').animate({
          scrollTop : 0                       // Scroll to top of body
      }, 500);
  });


  $(window).on('scroll', function(e){
    // console.log($(window).scrollTop())
    if($(window).width() > 1201){
      if($(window).scrollTop() <= 460){
        $("#fixed-left-bar").removeClass('fixed')
        $("#fixed-left-bar-wrapper").css('position', 'absolute').css('top', '420px')
      }

      else if($(window).scrollTop() > 460 && $(window).scrollTop() < 3180){
        $("#fixed-left-bar").addClass('fixed')
        $("#fixed-left-bar-wrapper").removeClass('left-bar-wrapper')
      }
      else if ($(window).scrollTop() >= 3180) {
        $("#fixed-left-bar").removeClass('fixed')
        $("#fixed-left-bar-wrapper").css('position', 'absolute').css('top', '3125px')
      }
      else{
        $("#fixed-left-bar").removeClass('fixed')
        $("#fixed-left-bar-wrapper").removeClass('left-bar-wrapper')
      }
    }
    else {
      if($(window).scrollTop() <= 460){
        $("#fixed-left-bar").removeClass('fixed')
        $("#fixed-left-bar-wrapper").css('position', 'absolute').css('top', '420px')
      }

      else if($(window).scrollTop() > 460 && $(window).scrollTop() < 3260){
        $("#fixed-left-bar").addClass('fixed')
        $("#fixed-left-bar-wrapper").removeClass('left-bar-wrapper')
      }
      else if ($(window).scrollTop() >= 3260) {
        $("#fixed-left-bar").removeClass('fixed')
        $("#fixed-left-bar-wrapper").css('position', 'absolute').css('top', '3210px')
      }
      else{
        $("#fixed-left-bar").removeClass('fixed')
        $("#fixed-left-bar-wrapper").removeClass('left-bar-wrapper')
      }
    }
  })

  $('.vertical-nav-item').on("click", function(){
    $('.vertical-nav-item').removeClass('active')
    $(this).addClass('active')
    var target = $(this).data("target")
    $('.content-wrapper .sec').addClass('hidden')
    $(target).removeClass('hidden')
  })

  $("input[name='consult_transaction[scheduled_date]']").on('change', function(e){
    console.log("change...", $(this).val())
    if($(this).val() == "" || $(this).val() == undefined){
      $("#place-order").attr('disabled', 'disabled')
    }
    else{
      $("#place-order").removeAttr('disabled')
    }

  })

})
