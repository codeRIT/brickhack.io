import './sass/bhclub.scss'
import '@fortawesome/fontawesome-free/css/all.css'
import $ from 'jquery'

// Navbar functionality
$(document).on('click', '#toggle', function() {
    if ($('nav').hasClass('show-nav')) {
        $('nav').removeClass('show-nav');
        $('#toggle').removeClass('fa-times');
        $('#toggle').addClass('fa-bars');
        $('main').removeClass('main-pointer');
    } else {
        $('nav').addClass('show-nav');
        $('#toggle').removeClass('fa-bars');
        $('#toggle').addClass('fa-times');
        $('main').addClass('main-pointer');
    }
});

// Closing the navbar when a navigation link is clicked
$(document).on('click', '.nav-link', function() {
    $('nav').removeClass('show-nav');
    $('#toggle').removeClass('fa-times');
    $('#toggle').addClass('fa-bars');
    $('main').removeClass('main-pointer');
});

// Closing the navbar when outside of the nav is clicked
$(document).on('click', 'main', function() {
    $('nav').removeClass('show-nav');
    $('#toggle').removeClass('fa-times');
    $('#toggle').addClass('fa-bars');
    $('main').removeClass('main-pointer');
});