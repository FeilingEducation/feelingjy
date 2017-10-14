'use strict';

$(document).on('change, slideStop', '.search-panel .search-input', function () {
  search();
});

// bootstrap-multiselect (https://github.com/davidstutz/bootstrap-multiselect)
// and
// bootstrap-slider (https://github.com/seiyria/bootstrap-slider)
// are used. They both replace a certain element with a more complex group of
// elements for better display. However, since we are using torbolinks, refreshing
// the page will replace the element repeatedly. Adding the data field "initialized"
// solves this problem.
$(document).on('turbolinks:load', function () {
  $('.slider-base[data-initialized!="1"]').attr('data-initialized', "1").slider();
  $('select[multiple="multiple"][data-initialized!="1"]').attr('data-initialized', "1").multiselect({
    nonSelectedText: $(this).data('non-selected-text'),
    allSelectedText: false,
    numberDisplayed: 1,
    nSelectedText: "已选中",
    onChange: search
  });
});

// Actually do the search. Not implemented yet.
function search() {}
