$(document).ready(function () {

  $('[data-school-picker]').autocomplete({
      // appendTo: 'div.school_selection',
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
      // hides helper messages
      messages: {
        noResults: '',
        results: function() {}
      },
      minLength: 3,
      select: function( event, ui ) {

      },
      open: function() {
      },
      close: function() {

      }
    });

});
