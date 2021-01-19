import './sass/gallery.scss'
import '@fortawesome/fontawesome-free/css/all.css'

import $ from 'jquery'

// Opening modal
$(document).on('click', function(event) {
    if ($(event.target).attr('class') == 'image') {
        $('#modal').show();
        $('#modal-background').show();
    }
});

// Closing modal with x
$('#close-modal').on('click', function() {
    $('#modal').hide();
    $('#modal-background').hide();
});

// Closing modal with background
$('#modal-background').on('click', function() {
    $('#modal').hide();
    $('#modal-background').hide();
});
