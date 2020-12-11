

import './sass/main.scss'
import '@fortawesome/fontawesome-free/css/all.css'


// slick-carousel configuration

import $ from 'jquery'
import 'slick-carousel'

$(document).ready(function() {
    $('.carousel').slick({
        infinite: true,
        swipeToSlide: true,
        variableWidth: true,
        slidesToShow: 3,
        slidesToScroll: 2,
        cssEase: 'ease-in-out',
        autoplay: true,
        autoplaySpeed: 2000,
        speed: 1000,
    });
});

let card = document.getElementsByClassName("card");
for (let i = 0; i < card.length; i++) {
    let accordion = card[i].getElementsByClassName("accordion-header")[0];
    // Click should only work on accordion-header of each card
    accordion.addEventListener("click", function() {

        card[i].classList.toggle("active");

        let panel = card[i].getElementsByClassName("panel")[0];
        let fa = this.getElementsByTagName("i")[0]

        // Toggle panel and plus/minus on click of header
        if ($(panel).css("display") == "none") {
            $(panel).show();
            $(fa).removeClass("fa-plus");
            $(fa).addClass("fa-minus");
        } else {
            $(panel).hide();
            $(fa).addClass("fa-plus");
            $(fa).removeClass("fa-minus");
        }
    });
}

// Schedule toggle code
$('.day-second-events').hide();
$('.day-first').click(function() {
    $('.day-first-events').show();
    $('.day-first').addClass('day-active');
    $('.day-second-events').hide();
    $('.day-second').removeClass('day-active');
});
$('.day-second').click(function() {
    $('.day-first-events').hide();
    $('.day-first').removeClass('day-active');
    $('.day-second-events').show();
    $('.day-second').addClass('day-active');
});
