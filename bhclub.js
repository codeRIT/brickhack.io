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
            $(panel).slideDown(200);
        } else {
            $(panel).slideUp(200);
        }

        $(fa).toggleClass("fa-plus");
        $(fa).toggleClass("fa-minus");
    });
}
