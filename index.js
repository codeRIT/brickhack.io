import './sass/main.scss'
import '@fortawesome/fontawesome-free/css/all.css'


// Hiring message
const hiringMessage = `Hey, you.
You’re finally awake.
You were trying to see the code, right?
Walked right into that hiring message, same as us.
If you’d like to work on this website and other cool projects with hackathons, send an email over to engineering@coderit.org!`

console.log(hiringMessage);

// Comment generated via js instead of directly in HTML so the hiring message text is only in one place
const comment = document.createComment("\n"+hiringMessage.toString()+"\n");
document.insertBefore(comment, document.firstChild);


// Nav highlighting on scroll
import ActiveMenuLink from "active-menu-link";

let options = {
    itemTag: "",
    scrollOffset: -90, // nav height
    scrollDuration: 1000,
    ease: "out-quart",
    showHash: false,
};

new ActiveMenuLink(".navbar-items", options);


// Random hero SVG on each page load
import desk1 from './assets/hero/desk1.svg'
import desk2 from './assets/hero/desk2.svg'
import desk3 from './assets/hero/desk3.svg'

$(document).ready(function() {
    var deskIndex = parseInt(localStorage.getItem('deskIndex'));
    if (!deskIndex) {
        deskIndex = 0;
        localStorage.setItem('deskIndex', 0);
    }
    var desks = [desk1, desk2, desk3]
    $('#desk').css('background-image', 'url(' + desks[deskIndex % desks.length] + ')');
    localStorage.setItem('deskIndex', deskIndex + 1);
});

// Parallax functionality
import Rellax from 'rellax';
var rellax = new Rellax('.rellax', {
    breakpoints:[0, 0, 900],
});

// Slick-carousel
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


// FAQ Cards hide/show
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

// Dynamic schedule code (sample API data)
function convertDate(date) {
    let output = '';

    // hour
    if (date.getUTCHours() > 12) {
        output = String(date.getUTCHours() - 12);
    } else {
        output = String(date.getUTCHours());
    }

    // minute
    if (date.getMinutes() !== 0) {
        output += ':' + String(date.getUTCMinutes()).padStart(2, '0');
    }

    // AM/PM
    if (date.getUTCHours() >= 12) {
        output += 'pm';
    } else {
        output += 'am';
    }

    return output;
}

function handleEventData(events) {
    events.forEach(event => {
        let startDate = new Date(event.start);  // convert ISO 8601 -> Date object
        let finishDate = undefined;

        let dateString = convertDate(startDate);
        if (event.finish) {  // finish === null for instantaneous events
            finishDate = new Date(event.finish);
            let finishString = convertDate(finishDate);
            if (dateString.slice(-2) === finishString.slice(-2)) {  // hide "am/pm" of first time if both are identical
                dateString = dateString.slice(0, -2);
            }
            dateString += "-" + convertDate(finishDate);
        }

        // calculate event container classes
        let divClasses = 'event';
        if ((finishDate || startDate) < new Date(1613914800 * 1000)) {  // replace second statement w/ "new Date()" after testing
            divClasses += ' past';
        }

        let eventContainer = $('.day-first-events');
        if (startDate.getDate() === 21) {
            eventContainer = $('.day-second-events');
        }
        eventContainer.append(`<div class="${divClasses}"><p class="time">${dateString}</p><p class="title">${event.title}</p></div>`);
    });
}

const events = [{"title":"Opening Ceremony","description":"","location":"Discord + Zoom","start":"2021-02-20T10:00:00+00:00","finish":"2021-02-20T10:30:00+00:00"},{"title":"Lunch (on your own!)","description":"","location":"Discord + Zoom","start":"2021-02-20T12:00:00+00:00","finish":null},{"title":"Mystery Workshop","description":"","location":"Discord + Zoom","start":"2021-02-20T14:00:00+00:00","finish":"2021-02-20T15:00:00+00:00"},{"title":"Mystery Event","description":"","location":"Discord + Zoom","start":"2021-02-20T17:00:00+00:00","finish":"2021-02-20T18:00:00+00:00"},{"title":"Devpost submission","description":"","location":"Discord + Zoom","start":"2021-02-21T10:00:00+00:00","finish":null},{"title":"Mystery Workshop 2","description":"","location":"Discord + Zoom","start":"2021-02-21T13:00:00+00:00","finish":"2021-02-21T14:00:00+00:00"},{"title":"Coding stops / Judging begins","description":"","location":"Discord + Zoom","start":"2021-02-21T12:30:00+00:00","finish":"2021-02-21T14:00:00+00:00"},{"title":"Closing Ceremony","description":"","location":"Discord + Zoom","start":"2021-02-21T14:00:00+00:00","finish":"2021-02-21T16:00:00+00:00"}];
handleEventData(events);

// Replace above two lines with this once we figure out the exact endpoint to use:
// fetch('http://example.com/schedule.json')
//     .then(res => res.json())
//     .then(events => handleEventData(events))
//     .catch(err => console.log(err));

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
