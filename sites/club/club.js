import './sass/club.scss'
import '@fortawesome/fontawesome-free/css/all.css'

// JQuery-UI for dropdown in Teams
const $ = require('jquery')
window.$ = window.jQuery = $
require("jquery-ui-bundle")

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

// Teams Dropdown
$( function() {
    $("#select-team").selectmenu();
})

// Changing shown team content based on selected team
// Initially displayed section
var selectedID = "#logistics-team";

$("#select-team").on("selectmenuchange", function(event, ui) {
    // Hide old selection
    $(selectedID).toggleClass("show-team");

    // Get the selected item
    selectedID = ui.item.value;

    // Show the new section
    $(selectedID).toggleClass("show-team");
} );
