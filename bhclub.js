import './sass/bhclub.scss'
import '@fortawesome/fontawesome-free/css/all.css'
import $ from 'jquery'

// Navbar functionality
$(document).on('click', '#toggle', function() {
    if ($('nav').hasClass('show-nav')) {
        $('nav').removeClass('show-nav');
        $('#toggle').removeClass('fa-times');
        $('#toggle').addClass('fa-bars');
    } else {
        $('nav').addClass('show-nav');
        $('#toggle').removeClass('fa-bars');
        $('#toggle').addClass('fa-times');
    }
});

// Closing the navbar when a navigation link is clicked
$(window).on('click', function(event) {
    if ($(event.target).hasClass('nav-link')) {
        $('nav').removeClass('show-nav');
        $('#toggle').removeClass('fa-times');
        $('#toggle').addClass('fa-bars');
    }
});

// TO DO:
// Figure out padding units
// Navbar open/close
// Done?
// What is the deal with padding? Should it be responsive?
// How should I handle mobile navbar? Where to put open/close icons? Grey out rest of screen? move it?