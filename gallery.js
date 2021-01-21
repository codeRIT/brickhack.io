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

// Navbar functionality
$(document).on('click', '#toggler', function() {
    if ($('.navlinks').hasClass('show-menu')) {
        $('.navlinks').removeClass('show-menu');
        $('#toggler').removeClass('fa-times');
        $('#toggler').addClass('fa-bars');
    } else {
        $('.navlinks').addClass('show-menu');
        $('#toggler').removeClass('fa-bars');
        $('#toggler').addClass('fa-times');
    }
});

// Closing the navbar when a navigation link is clicked
$(window).on('click', function(event) {
    if ($(event.target).hasClass('navlink')) {
        $('.navlinks').removeClass('show-menu');
        $('#toggler').removeClass('fa-times');
        $('#toggler').addClass('fa-bars');
    }
});
