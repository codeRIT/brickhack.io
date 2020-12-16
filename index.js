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
        autoplay: true,
        autoplaySpeed: 2000,
        speed: 1000,
        responsive: [
            {
                breakpoint: 1100,
                settings: {
                    centerMode: true
                }
            }
        ]
    });
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

const events = [{"title":"Opening Ceremony","description":"","location":"Discord + Zoom","start":"1613815200","finish":"1613817000"},{"title":"Lunch (on your own!)","description":"","location":"Discord + Zoom","start":"1613822400","finish":"1613822400"},{"title":"Mystery Workshop","description":"","location":"Discord + Zoom","start":"1613829600","finish":"1613919600"},{"title":"Mystery Event","description":"","location":"Discord + Zoom","start":"1613840400","finish":"1613844000"},{"title":"Devpost submission","description":"","location":"Discord + Zoom","start":"1613901600","finish":"1613901600"},{"title":"Mystery Workshop 2","description":"","location":"Discord + Zoom","start":"1613912400","finish":"1613916000"},{"title":"Coding stops / Judging begins","description":"","location":"Discord + Zoom","start":"1613910600","finish":"1613916000"},{"title":"Closing Ceremony","description":"","location":"Discord + Zoom","start":"1613916000","finish":"1613923200"}];
events.forEach(event => {
    let startDate = new Date(Number(event.start) * 1000);  // convert timestamp -> milliseconds -> Date object
    let finishDate = new Date(Number(event.finish) * 1000);
    
    let dateString = convertDate(startDate);
    if (startDate.getTime() !== finishDate.getTime()) {  // instantaneous events don't need the second part
        let finishString = convertDate(finishDate);
        if (dateString.slice(-2) === finishString.slice(-2)) {  // hide "am/pm" of first time if both are identical
            dateString = dateString.slice(0, -2);
        }
        dateString += "-" + convertDate(finishDate);
    }

    let eventContainer = $('.day-first-events');
    if (startDate.getDate() === 21) {
        eventContainer = $('.day-second-events');
    }
    eventContainer.append(`<div class="event"><p class="time">${dateString}</p><p class="title">${event.title}</p></div>`);
});

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
