

import './sass/main.scss'
import '@fortawesome/fontawesome-free/css/all.css'


// slick-carousel configuration

import $ from 'jquery'
import 'slick-carousel'

$(document).ready(function() {
    $('.carousel').slick({
        infinite: true,
        speed: 500,
        swipeToSlide: true,
        variableWidth: true,
        slidesToShow: 3,
        slidesToScroll: 2,
        autoplay: true,
        autoplaySpeed: 500
    });
});