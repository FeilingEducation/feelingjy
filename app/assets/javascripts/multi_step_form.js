'use strict';

$(document).on('click', '#regi-complete', function () {
  $("#loading").removeClass("d-none")
});

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
  var $targetHref = $($this).data('target')
  var isUpload = false;
  if(!$this.is('.submit')) {

    // Implement validations
    // $($('.current-step .question-block')[0]).find('input[type=checkbox]:checked').length
    $.map($('.current-step .question-block'), function(question_block, index){
      if($(question_block).find('input[type=checkbox]').length > 0 && !$('.current-step').hasClass('step3') ){
        // there are checkboxes present on the step. Make sure that user selects some value.
        if($(question_block).find('input[type=checkbox]:checked').length == 0){
          isValid = false
          console.log('checkbox validation fails...')
        }
      }

      if($('#step1').hasClass('current-step')){
        console.log("112312312")
        console.log($("select[name='instructor_info[specialization][]']").val())
        if($("select[name='instructor_info[specialization][]']").val()){
          console.log("=======")
          isValid = true
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

      // Check if files are attached properly
      if($(question_block).find('input[type=file]').length > 0){
        // there are number fields present on the screeb. Make sure that user selects some value.
        $.map($(question_block).find('input[type=file]'), function(file_field, index){
          if($(file_field).val().length == 0){
            isValid = false;
            isUpload = true;
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
            // $('#description-char-count span').text($(textarea).val().length)
            // if($(textarea).val().length < 400){
            //   isValid = false;
            //   $(textarea).next('span.error').removeClass('hidden')
            // }
            // else{
            //   $(textarea).next('span.error').addClass('hidden')
            // }
            isValid = true;  // lei added this to skip 400 words description at registration step 8
          }
        })
      }
    })
    console.log("isValid111", isValid)

    if($('#step23').hasClass('current-step')){
      isValid = true
      if($('input[name="instructor_info[recommended_price]"]:checked').val()=="true"){
        console.log("checking!!!")

        if($("select[name='instructor_info[consulting_tutor]']").val() == "1"){
          console.log("Checking consultant...")
          if($("input[name='instructor_info[consult_min_price]']").val() == "" || $("input[name='instructor_info[consult_max_price]']").val() == "" ){
            isValid = false
          }else if(parseInt($("input[name='instructor_info[consult_min_price]']").val()) > parseInt($("input[name='instructor_info[consult_max_price]']").val())){
            isValid = false
            $("input[name='instructor_info[consulting_max_price]']").next('span.error').removeClass('hidden')
          }
          else{
            $("input[name='instructor_info[consulting_max_price]']").next('span.error').addClass('hidden')
          }

          if($("input[name='instructor_info[consult_min_price]']").val() < 100){
            isValid = false
            $(".consult_error_min").removeClass('hidden')
          }
          else{
            $(".consult_error_min").addClass('hidden')
          }

          if($("input[name='instructor_info[consult_max_price]']").val() > 6000){
            isValid = false
            $(".consult_error_max").removeClass('hidden')
          }
          else{
            $(".consult_error_max").addClass('hidden')
          }

        }

        if($("select[name='instructor_info[brainstorming_tutor]']").val() == "1"){
          console.log("brainstorming consultant...")
          if($("input[name='instructor_info[brainstorm_min_price]']").val() == "" || $("input[name='instructor_info[brainstorm_max_price]']").val() == "" ){
            isValid = false
          }else if(parseInt($("input[name='instructor_info[brainstorm_min_price]']").val()) > parseInt($("input[name='instructor_info[brainstorm_max_price]']").val())){
            isValid = false
            $("input[name='instructor_info[brainstorm_max_price]']").next('span.error').removeClass('hidden')
          }
          else{
            $("input[name='instructor_info[brainstorm_max_price]']").next('span.error').addClass('hidden')
          }

          if($("input[name='instructor_info[brainstorm_min_price]']").val() < 100){
            isValid = false
            $(".brainstorm_error_min").removeClass('hidden')
          }
          else{
            $(".brainstorm_error_min").addClass('hidden')
          }

          if($("input[name='instructor_info[brainstorm_max_price]']").val() > 6000){
            isValid = false
            $(".brainstorm_error_max").removeClass('hidden')
          }
          else{
            $(".brainstorm_error_max").addClass('hidden')
          }
        }

        if($("select[name='instructor_info[writing_tutor]']").val() == "1"){
          console.log("Checking consultant111...")
          if($("input[name='instructor_info[essay_min_price]']").val() == "" || $("input[name='instructor_info[essay_max_price]']").val() == "" ){
            isValid = false
          }else if(parseInt($("input[name='instructor_info[essay_min_price]']").val()) > parseInt($("input[name='instructor_info[essay_max_price]']").val())){
            isValid = false
            $("input[name='instructor_info[essay_max_price]']").next('span.error').removeClass('hidden')
          }
          else{
            $("input[name='instructor_info[essay_max_price]']").next('span.error').addClass('hidden')
          }

          if($("input[name='instructor_info[essay_min_price]']").val() < 100){
            isValid = false
            $(".essay_error_min").removeClass('hidden')
          }
          else{
            $(".essay_error_min").addClass('hidden')
          }

          if($("input[name='instructor_info[essay_max_price]']").val() > 6000){
            isValid = false
            $(".essay_error_max").removeClass('hidden')
          }
          else{
            $(".essay_error_max").addClass('hidden')
          }
        }

        if($("select[name='instructor_info[visa_consultant]']").val() == "1"){
          console.log("Checking consultant222...")
          if($("input[name='instructor_info[visa_min_price]']").val() == "" || $("input[name='instructor_info[visa_max_price]']").val() == "" ){
            isValid = false
          }else if(parseInt($("input[name='instructor_info[visa_min_price]']").val()) > parseInt($("input[name='instructor_info[visa_max_price]']").val())){
            isValid = false
            $("input[name='instructor_info[visa_max_price]']").next('span.error').removeClass('hidden')
          }
          else{
            $("input[name='instructor_info[visa_max_price]']").next('span.error').addClass('hidden')
          }

          if($("input[name='instructor_info[visa_min_price]']").val() < 100){
            isValid = false
            $(".visa_error_min").removeClass('hidden')
          }
          else{
            $(".visa_error_min").addClass('hidden')
          }

          if($("input[name='instructor_info[visa_max_price]']").val() > 6000){
            isValid = false
            $(".visa_error_max").removeClass('hidden')
          }
          else{
            $(".visa_error_max").addClass('hidden')
          }
        }
      }
      else{

        if($("select[name='instructor_info[consulting_tutor]']").val() == "1"){
          if($("input[name='instructor_info[consult_fix_price]']").val() == ""){
            isValid = false
          }
        }

        if($("select[name='instructor_info[brainstorming_tutor]']").val() == "1"){
          if($("input[name='instructor_info[brainstorm_fix_price]']").val() == ""){
            isValid = false
          }
        }

        if($("select[name='instructor_info[writing_tutor]']").val() == "1"){
          if($("input[name='instructor_info[essay_fix_price]']").val() == ""){
            isValid = false
          }
        }

        if($("select[name='instructor_info[visa_consultant]']").val() == "1"){
          if($("input[name='instructor_info[visa_fix_price]']").val() == ""){
            isValid = false
          }
        }

      }
    }

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
    if($("select[name='instructor_info[uni_accepted][]']").length > 0 && $("select[name='instructor_info[uni_accepted][]']").val() && $("select[name='instructor_info[uni_accepted][]']").val().length == 0){
      isValid = false
    }

    // $target_form check if user has click on Done after uplaoding profile picture.
    console.log("===========", $targetHref.toString() == '#step11')
    console.log("isValid112", isValid)
    if($targetHref == '#step11'){
      isValid = !($("#avatar-preview").val() == '')
      isUpload = true;
    }
    console.log("isValid113", isValid)
    if(isValid || $this.hasClass('btn-default')){
      $curr_form.toggleClass('current-step');
      $target_form.toggleClass('current-step');
      // $target_form.find('input, select').filter(':first').focus();
      $('.progress .progress-bar').css('width', $(this).data('percentage'))
      $('.snack-bar-error').removeClass('show')
      $(window).scrollTop(0)
    }
    else{
      if(isUpload){
        $('.snack-bar-error-upload').addClass('show')
        setTimeout(function(){
          $('.snack-bar-error-upload').removeClass('show')
        },3000)
        // alert('Please fill in all fields...')
      }
      else{
        console.log("in here")
        $('.snack-bar-error').addClass('show')
        setTimeout(function(){
          $('.snack-bar-error').removeClass('show')
        },3000)
        // alert('Please fill in all fields...')
      }
    }
  }
});
function initFileCrop() {

  // because every time we click "go back" and then "go forth", or simply refresh the page,
  // the turbolinks will load. this function will trigger twice. So this is the sequence (manually) to
  // reset before intialization
  $('#pic-placeholder').removeClass('croppie-container')
  $('#pic-placeholder .cr-boundary').remove()
  $('#pic-placeholder .cr-slider-wrap').remove()
  $('#pic-placeholder').removeClass('image-laoded')
  $('#pic-placeholder').removeClass('image-done')
  $(".set-image").addClass('hidden')
  $("#upload-btn").removeClass('hidden')
  $("#avatar-preview").val('')
  $("#avatar-image").val('')
  $('.cr-image').attr('src','')

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
      width: 170,
      height: 170,
      type: 'circle'
    },
    enableExif: true
  })

  $('#avatar-image').on('change', function () { readFile(this);
    console.log('changed....')
    $('#pic-placeholder').addClass('image-laoded')
    $('#pic-placeholder').removeClass('image-done')
    $(".set-image").removeClass('hidden')
    $("#upload-btn").addClass('hidden')
  });

  $('#set-image').on('click', function (ev) {
    console.log("Set Image clicked...")
    $uploadCrop.croppie('result', {
      type: 'base64',
      size: 'viewport'
    }).then(function (resp) {
      console.log('Done')
      console.log(resp)
      console.log('===================================')
      $("#avatar-preview").val(resp)
      $(".set-image").addClass('hidden')
      $("#upload-btn").removeClass('hidden')
      $('#pic-placeholder').addClass('image-done')
      $('#pic-placeholder').removeClass('image-laoded')
    });
  })

  $('#reset-image').on('click', function (ev) {
    console.log("reset-image...")
    $('#pic-placeholder').removeClass('image-laoded')
    $('#pic-placeholder').removeClass('image-done')
    $(".set-image").addClass('hidden')
    $("#upload-btn").removeClass('hidden')
    $("#avatar-preview").val('')
    $("#avatar-image").val('')
    $('.cr-image').attr('src','')
  })
}

function managePrices(id){
  console.log("managePrices...", id)
  if($("select[name='instructor_info[consulting_tutor]']").val() == "1"){
    $("#"+id+" .consulting-service").removeClass('hidden')
  }
  if($("select[name='instructor_info[brainstorming_tutor]']").val() == "1"){
    $("#"+id+" .brainstorming-service").removeClass('hidden')
  }
  if($("select[name='instructor_info[writing_tutor]']").val() == "1"){
    $("#"+id+" .writing-service").removeClass('hidden')
  }
  if($("select[name='instructor_info[visa_consultant]']").val() == "1"){
    $("#"+id+" .visa-service").removeClass('hidden')
  }

  if($("select[name='instructor_info[consulting_tutor]']").val() == "0"){
    $("#"+id+" .consulting-service").addClass('hidden')
  }
  if($("select[name='instructor_info[brainstorming_tutor]']").val() == "0"){
    $("#"+id+" .brainstorming-service").addClass('hidden')
  }
  if($("select[name='instructor_info[writing_tutor]']").val() == "0"){
    $("#"+id+" .writing-service").addClass('hidden')
  }
  if($("select[name='instructor_info[visa_consultant]']").val() == "0"){
    $("#"+id+" .visa-service").addClass('hidden')
  }
}


// to destroy all the extra select2 prior to turbolinks reload
$(document).on("turbolinks:before-cache", function() {
    $('.select2-hidden-accessible').select2('destroy');
});

$(document).on('turbolinks:load', function () {
// $('.become-mentor').on('click', function () {
  $("#loading").addClass("d-none")
  
  initFileCrop()

  $('#step0').addClass('current-step')
  $('#step1').removeClass('current-step')
  $('#step2').removeClass('current-step')
  $('#step3').removeClass('current-step')
  $('#step4').removeClass('current-step')
  $('#step5').removeClass('current-step')
  $('#step6').removeClass('current-step')
  $('#step7').removeClass('current-step')
  $('#step8').removeClass('current-step')
  $('#step9').removeClass('current-step')
  $('#step10').removeClass('current-step')
  $('#step11').removeClass('current-step')
  $('#step12').removeClass('current-step')
  $('#step13').removeClass('current-step')
  $('#step14').removeClass('current-step')
  $('#step15').removeClass('current-step')
  $('#step16').removeClass('current-step')
  $('#step17').removeClass('current-step')
  $('#step18').removeClass('current-step')
  $('#step19').removeClass('current-step')
  $('#step20').removeClass('current-step')
  $('#step21').removeClass('current-step')
  $('#step22').removeClass('current-step')
  $('#step23').removeClass('current-step')
  $('#step26').removeClass('current-step')

  managePrices("price-range-fields")
  managePrices("fixed-price-fields")
  $('input[type=radio][name="instructor_info[recommended_price]"]').change(function() {
    if(this.value == 'true'){
      $("#price-range-fields").removeClass("hidden")
      $("#fixed-price-fields").addClass("hidden")
      managePrices("price-range-fields")
    }
    else{
      $("#fixed-price-fields").removeClass("hidden")
      $("#price-range-fields").addClass("hidden")
      managePrices("fixed-price-fields")
    }
    console.log("changed....")
    console.log(this.value)
  });
})
