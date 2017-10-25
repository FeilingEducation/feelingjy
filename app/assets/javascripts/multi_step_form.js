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
        $.map($(question_block).find('input[type=number]'), function(text_box, index){
          if($(text_box).val().length == 0){
            isValid = false;
            console.log('number validation fails...')
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
        })
      }
    })
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
});
