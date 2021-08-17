import './sass/bhclub.scss'
import '@fortawesome/fontawesome-free/css/all.css'
import $ from 'jquery'

// Navbar functionality
$(document).on('click', '#toggle', function() {
    if ($('nav').hasClass('show-nav')) {
        $('nav').removeClass('show-nav');
        $('#toggle').removeClass('fa-times');
        $('#toggle').addClass('fa-bars');
        $('.mobile-grayout').removeClass("show-gray");
    } else {
        $('nav').addClass('show-nav');
        $('#toggle').removeClass('fa-bars');
        $('#toggle').addClass('fa-times');
        $('.mobile-grayout').addClass("show-gray");
    }
});

// Closing the navbar when a navigation link is clicked
$(document).on('click', '.nav-link', function() {
    $('nav').removeClass('show-nav');
    $('#toggle').removeClass('fa-times');
    $('#toggle').addClass('fa-bars');
    $('.mobile-grayout').removeClass("show-gray");
});

// Closing the navbar when outside of the nav is clicked
$(document).on('click', '.mobile-grayout', function() {
    $('nav').removeClass('show-nav');
    $('#toggle').removeClass('fa-times');
    $('#toggle').addClass('fa-bars');
    $('.mobile-grayout').removeClass("show-gray");
});

// FAQ Cards hide/show
let card = document.getElementsByClassName("card");
for (let i = 0; i < card.length; i++) {
    let accordion = card[i].getElementsByClassName("card-header")[0];
    // Click should only work on accordion-header of each card
    accordion.addEventListener("click", function() {
        card[i].classList.toggle("card-open");

        let panel = card[i].getElementsByClassName("card-body")[0];
        let fa = this.getElementsByTagName("i")[0];

        // Toggle panel and plus/minus on click of header
        if ($(card[i]).hasClass("card-open")) {
            $(panel).slideDown(100);
        } else {
            $(panel).slideUp(100);
        }

        $(fa).toggleClass("fa-plus");
        $(fa).toggleClass("fa-minus");
    });
}
