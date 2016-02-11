$.fn.bulkRowEdit = function() {

  var applyAction = function() {
    $('[type=submit][data-bulk-row-edit]').prop('disabled', true);

    var ids = [];
    $('input[type=checkbox][data-bulk-row-edit]:checked').each(function() {
      ids[ids.length] = $(this).data('bulk-row-edit');
    });

    var action = $('select[data-bulk-row-edit]').val();

    if (ids.length == 0) {
      alert('No rows are selected to be modified!');
      $('[type=submit][data-bulk-row-edit]').prop('disabled', false);
      return false;
    }

    $.ajax({
      url: $('form[data-bulk-row-edit]').attr('action'),
      type: 'PATCH',
      data: {
        bulk_action: action,
        bulk_ids: ids
      }
    }).done(function() {
      window.questionnairesDataTable.draw(false);
    }).fail(function() {
      alert("Request failed, please refresh the page or try again later.");
    }).always(function() {
      $('[type=submit][data-bulk-row-edit]').prop('disabled', false);
    });

    return true;
  };

  $('[type=submit][data-bulk-row-edit]').on('click', function(e) {
    e.preventDefault();
    return applyAction();
  });

};
