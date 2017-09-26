$(document).on('change, slideStop', '.search-panel .search-input', function() {
  search();
});

$(document).on('turbolinks:load', function() {
  $('.slider-base[data-initialized!="1"]').attr('data-initialized', "1").slider();
  $('select[multiple="multiple"][data-initialized!="1"]').attr('data-initialized', "1").multiselect({
    nonSelectedText: $(this).data('non-selected-text'),
    allSelectedText: false,
    numberDisplayed: 1,
    nSelectedText: "已选中",
    onChange: search
  });
});

function search() {
}
