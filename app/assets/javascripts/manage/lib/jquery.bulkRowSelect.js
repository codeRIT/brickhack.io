$.fn.bulkRowSelect = function() {

  var applyAction = function() {
    var checkState = $('[data-bulk-row-select]').prop('checked');
    $('input[type=checkbox][data-bulk-row-edit]').prop('checked', checkState);
    return true;
  };

  $('[data-bulk-row-select]').on('click', function(e) {
    return applyAction();
  });

};
