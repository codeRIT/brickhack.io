import './sass/gallery.scss'
import '@fortawesome/fontawesome-free/css/all.css'

import $ from 'jquery'

// Navbar functionality
$(document).on('click', '#toggler', function() {
    console.log($('.navlinks').attr('class'));
    if ($('.navlinks').hasClass('show-menu')) {
        console.log('close menu');
        $('.navlinks').removeClass('show-menu');
        $('#toggler').removeClass('fa-times');
        $('#toggler').addClass('fa-bars');
    } else {
        console.log('opening menu');
        $('.navlinks').addClass('show-menu');
        $('#toggler').removeClass('fa-bars');
        $('#toggler').addClass('fa-times');
    }
});
// Closing the navbar when a navigation link is clicked
$(window).on('click', function(event) {
    if ($(event.target).hasClass('navlink')) {
        console.log('close menu');
        $('.navlinks').removeClass('show-menu');
        $('#toggler').removeClass('fa-times');
        $('#toggler').addClass('fa-bars');
    }
});
