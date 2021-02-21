import './sass/event.scss'
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

// Schedule toggle code

$('.pre-event').click(function() {
    $('.pre-event').addClass('schedule-tab-active');
    $('.feb-20').removeClass('schedule-tab-active');
    $('.feb-21').removeClass('schedule-tab-active');
    $('#pre-event-content').css('display', 'flex');
    $('#feb-20-content').hide();
    $('#feb-21-content').hide();
});

$('.feb-20').click(function() {
    $('.pre-event').removeClass('schedule-tab-active');
    $('.feb-20').addClass('schedule-tab-active');
    $('.feb-21').removeClass('schedule-tab-active');
    $('#pre-event-content').hide();
    $('#feb-20-content').show();
    $('#feb-21-content').hide();
});

$('.feb-21').click(function() {
    $('.pre-event').removeClass('schedule-tab-active');
    $('.feb-20').removeClass('schedule-tab-active');
    $('.feb-21').addClass('schedule-tab-active');
    $('#pre-event-content').hide();
    $('#feb-20-content').hide();
    $('#feb-21-content').show();
});

$('.show-full-schedule').click(function() {
    $('#feb-20-content .events').css('height', 'auto'); // Easier w/o conditional
    $('#feb-21-content .events').css('height', 'auto');
    $('.hide-full-schedule').css('display', 'flex');
    $('.show-full-schedule').hide();
});

$('.hide-full-schedule').click(function() {
    $('#feb-20-content .events').css('height', '370px'); // Easier w/o conditional
    $('#feb-21-content .events').css('height', '370px');
    $('.hide-full-schedule').hide();
    $('.show-full-schedule').css('display', 'flex');
});

// Set schedule tab based on the date
let currentDate = new Date().getDate()
if (currentDate < 20) {
    $('#pre-event-tab').addClass('schedule-tab-active');
    $('#pre-event-content').show();
    $('#feb-20-content').hide();
    $('#feb-21-content').hide();
} else if (currentDate == 20) {
    $('#feb-20-tab').addClass('schedule-tab-active');
    $('#pre-event-content').hide();
    $('#feb-20-content').show();
    $('#feb-21-content').hide();
} else {
    $('#feb-21-tab').addClass('schedule-tab-active');
    $('#pre-event-content').hide();
    $('#feb-20-content').hide();
    $('#feb-21-content').show();
}

// Dynamic schedule code

function compareEvents(a, b) {
    // We can sort by start/end here because the ISO 8061
    // timestamps given by the server are lexicographically
    // sortable.

    if (a.start < b.start) {         // if a starts before b...
        return -1;                   //   ...then a goes before b
    } else if (a.start > b.start) {  // if a starts after b...
        return 1;                    //   ...then b goes before a
    } else {
        if (a.end < b.end) {         // if a ends before b...
            return -1;               //   ...then a goes before b
        } else if (a.end > b.end) {  // if a ends after b...
            return 1;                //   ...then b goes before a
        } else {
            return 0;
        }
    }
}

function convertDate(date) {
    let output = '';

    // hour
    if (date.getHours() > 12) {
        output = String(date.getHours() - 12);
    } else {
        output = String(date.getHours());
    }

    // minute
    if (date.getMinutes() !== 0) {
        output += ':' + String(date.getMinutes()).padStart(2, '0');
    }

    // AM/PM
    if (date.getHours() >= 12) {
        output += 'pm';
    } else {
        output += 'am';
    }

    return output;
}

function handleEventData(events) {
    let now = new Date()

    // needed to handle overlapping events
    let timeMarkerAdded = false;

    // need to sort events by start/end times instead of IDs
    events.sort(compareEvents);

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
        if ((finishDate || startDate) < now) {
            divClasses += ' past';
        }

        // add event to DOM
        var eventContainer;

        switch (startDate.getDate()) {
            case 16: eventContainer = $('.pre-event-16-events'); break;
            case 17: eventContainer = $('.pre-event-17-events'); break;
            case 18: eventContainer = $('.pre-event-18-events'); break;
            case 19: eventContainer = $('.pre-event-19-events'); break;
            case 20: eventContainer = $('.feb-20-events'); break;
            case 21: eventContainer = $('.feb-21-events'); break;
        }

        if (!eventContainer) {
            console.log("Event " + event.title + " date " + startDate + " out of range.");
            return; // skip current iteration https://stackoverflow.com/a/31399448/1431900
        }

        const eventDiv = eventContainer.append(`<div class="${divClasses}"><p class="time">${dateString}</p><p class="title">${event.title}</p></div>`);

        // add time indicator for the current event
        if (!timeMarkerAdded && startDate < now && finishDate > now) {
            timeMarkerAdded = true;

            // calculate percent
            const eventLength = finishDate - startDate;
            const percent = ((now - startDate) / eventLength) * 100;

            eventDiv.children('div:last-child').css('background-image', `linear-gradient(0deg, white, white ${100-percent}%, #bfbfbf 0)`);
            eventDiv.children('div:last-child').append(`<div class="marker" style="top: ${percent}%;"></div>`);
        }
    });
}

fetch('https://apply.brickhack.io/events.json')
    .then(res => res.json())
    .then(events => handleEventData(events))
    .catch(err => console.log(err));
