$(document).ready(function () {

  $('[data-school-picker]').autocomplete({
      source: function( request, response ) {
        $.ajax({
          url: '/apply/schools',
          dataType: 'json',
          data: {
            name: request.term
          },
          success: function( data ) {
            response( data );
          }
        });
      },
      minLength: 3,
      select: function( event, ui ) {
        console.log(ui.item);
        $($(this).data('school-picker')).val(Math.floor(Math.random() * 10000));
      },
      open: function() {
        $( this ).removeClass('ui-corner-all').addClass('ui-corner-top');
      },
      close: function() {
        $( this ).removeClass('ui-corner-top').addClass('ui-corner-all');
      }
    });

});
