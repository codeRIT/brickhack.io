import './sass/main.scss'
import '@fortawesome/fontawesome-free/css/all.css'

// slick-carousel configuration
import $ from 'jquery'
import 'slick-carousel'


const hiringMessage = `Hey, you.
You’re finally awake.
You were trying to see the code, right?
Walked right into that hiring message, same as us.
If you’d like to work on this website and other cool projects with hackathons, send an email over to engineering@coderit.org!`

console.log(hiringMessage);

// comment generated via js instead of directly in HTML so the hiring message text is only in one place
const comment = document.createComment("\n"+hiringMessage.toString()+"\n");
document.insertBefore(comment, document.firstChild);


$(document).ready(function() {
    $('.carousel').slick({
        infinite: true,
        swipeToSlide: true,
        variableWidth: true,
        slidesToShow: 3,
        slidesToScroll: 2,
        cssEase: 'ease-in-out',
        autoplay: false,
        autoplaySpeed: 2000,
        speed: 1000,
        responsive: [
            {
                breakpoint: 1500,
                settings: {
                    centerMode: true
                }
            }
        ]
    });
});

// Opens modal when img is clicked
$(document).on('click', '.slide-image', function() {
    $('#modal').show();
    $('#modal-content').attr('src', this.src);
});

// Closes modal when X is clicked
$(document).on('click', '#close', function() {
    $('#modal').hide();
});

// Closes modal when window is clicked
$(window).on('click', function(event) {
    if (event.target == modal) {
        $('#modal').hide();
    }
});

// Closes modal when esc key is pressed
$(document).on('keydown', function(event) {
    if (event.key == "Escape") {
        $('#modal').hide();
    }
});


let card = document.getElementsByClassName("card");
for (let i = 0; i < card.length; i++) {
    let accordion = card[i].getElementsByClassName("accordion-header")[0];
    // Click should only work on accordion-header of each card
    accordion.addEventListener("click", function() {

        card[i].classList.toggle("active");

        let panel = card[i].getElementsByClassName("panel")[0];
        let fa = this.getElementsByTagName("i")[0];

        // Toggle panel and plus/minus on click of header
        if ($(card[i]).hasClass("active")) {
            $(panel).slideDown(200);
        } else {
            $(panel).slideUp(200);
        }

        $(fa).toggleClass("fa-plus");
        $(fa).toggleClass("fa-minus");
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
