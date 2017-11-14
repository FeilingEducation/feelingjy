'use strict';

// navigate through multi-step-form
$(document).on('click', '.multi-step-form .step-navigate', function () {
  var $this = $(this);
  // if ($this.is('.submit')) {
  //   $this.closest('form').submit();
  //   return;
  // }
  var $curr_form = $this.closest('.multi-step-form');
  var $target_form = $($this.data('target'));
  var isValid = true;
  if(!$this.is('.submit')) {

    // Implement validations
    // $($('.current-step .question-block')[0]).find('input[type=checkbox]:checked').length
    $.map($('.current-step .question-block'), function(question_block, index){
      if($(question_block).find('input[type=checkbox]').length > 0){
        // there are checkboxes present on the step. Make sure that user selects some value.
        if($(question_block).find('input[type=checkbox]:checked').length == 0){
          isValid = false
          console.log('checkbox validation fails...')
        }
      }
      // Check if there are radio buttons on screen
      if($(question_block).find('input[type=radio]').length > 0){
        // there are radio buttons present on the screeb. Make sure that user selects some value.
        console.log($(question_block))
        console.log($(question_block).find('input[type=radio]:checked').val())
        if($(question_block).find('input[type=radio]:checked').val() == undefined){
          isValid = false;
          console.log('radio validation fails...')
        }
      }

      // Check if there are text boxes present on screen
      if($(question_block).find('input[type=text]').length > 0){
        // there are text boxes present on the screeb. Make sure that user selects some value.
        $.map($(question_block).find('input[type=text]'), function(text_box, index){
          if($(text_box).val().length == 0){
            isValid = false;
            console.log('text validation fails...')
          }
        })
      }

      // Check if there are number fields present on screen
      if($(question_block).find('input[type=number]').length > 0){
        // there are number fields present on the screeb. Make sure that user selects some value.
        $.map($(question_block).find('input[type=number]'), function(number_field, index){
          if($(number_field).val().length == 0){
            isValid = false;
            console.log('number validation fails...')
          }
        })
      }

      // Check if there are number fields present on screen
      if($(question_block).find('input[type=file]').length > 0){
        // there are number fields present on the screeb. Make sure that user selects some value.
        $.map($(question_block).find('input[type=file]'), function(file_field, index){
          if($(file_field).val().length == 0){
            isValid = false;
            console.log('file field validation fails...')
          }
        })
      }

      // Check if there are text areas present on screen
      if($(question_block).find('textarea').length > 0){
        // there are text areas present on the screeb. Make sure that user selects some value.
        $.map($(question_block).find('textarea'), function(textarea, index){
          if($(textarea).val().length == 0){
            isValid = false;
            console.log('textarea validation fails...')
          }
          if($(textarea).attr('id') == "description"){
            $('#description-char-count span').text($(textarea).val().length)
            if($(textarea).val().length < 400){
              isValid = false;
              $(textarea).next('span.error').removeClass('hidden')
            }
            else{
              $(textarea).next('span.error').addClass('hidden')
            }
          }
        })
      }
    })

    // Number fields
    if(parseInt($('#max_price').val()) < parseInt($('#min_price').val())){
      isValid = false;
      $('#max_price').next('span.error').removeClass('hidden')
    }else{
      $('#max_price').next('span.error').addClass('hidden')
    }
    if(parseInt($('#max_days').val()) < parseInt($('#min_days').val())){
      isValid = false;
      $('#max_days').next('span.error').removeClass('hidden')
    }else{
      $('#max_days').next('span.error').addClass('hidden')
    }

    if(isValid || $this.hasClass('btn-default')){
      $curr_form.toggleClass('current-step');
      $target_form.toggleClass('current-step');
      $target_form.find('input, select').filter(':first').focus();
      $('.progress .progress-bar').css('width', $(this).data('percentage'))
      $('.snack-bar-error').removeClass('show')
      $(window).scrollTop(0)
    }
    else{
      $('.snack-bar-error').addClass('show')
      setTimeout(function(){
        $('.snack-bar-error').removeClass('show')
      },3000)
      // alert('Please fill in all fields...')
    }
  }
});
function demoUpload() {
  var $uploadCrop;

  function readFile(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        // $('.upload-demo').addClass('ready');
        $uploadCrop.croppie('bind', {
          url: e.target.result
        }).then(function(){
          console.log('jQuery bind complete');
        });

      }

      reader.readAsDataURL(input.files[0]);
    }
    else {
      swal("Sorry - you're browser doesn't support the FileReader API");
    }
  }

  $uploadCrop = $('#pic-placeholder').croppie({
    viewport: {
      width: 100,
      height: 100,
      type: 'circle'
    },
    enableExif: true
  })

  $('#avatar-image').on('change', function () { readFile(this);
    $("#set-image").removeClass('hidden')
  });

  $('#set-image').on('click', function (ev) {
    $uploadCrop.croppie('result', {
      type: 'base64',
      size: 'viewport'
    }).then(function (resp) {
      console.log('==============',resp)
      $("#avatar-preview").val(resp)
    });
  })
}
  $(document).on('turbolinks:load', function () {
    console.log('/demoUpload///////......')
    demoUpload()
  })
