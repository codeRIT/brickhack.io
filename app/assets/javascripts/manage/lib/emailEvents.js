$(document).ready(function () {
  $('.email-events').each(function() {
    var events_container = this;

    $(events_container).html('<span class="fa fa-circle-o-notch fa-spin"></span>');

    var data_url = $(events_container).data('url');
    $.ajax(data_url)
      .done(function(json) {
        if (!json.length) {
          $(events_container).html('<em>No events found.</em>');
          return;
        }

        var $new_html = $('<ul>');
        $(json).each(function(_, event) {
          $new_html.append('<li><p>' + event.subject + ' : <strong>' + event.type + '</strong><br><em>' + event.timestamp + '</em></p></li>');
        });
        $(events_container).html($new_html);
      })
      .fail(function() {
        $(events_container).html('<em>An error ocurred. Please try again later.</em>');
      });
  });
});
