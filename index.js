import "./sass/index.scss"
import "@fortawesome/fontawesome-free/css/all.css"
import $ from "jquery"

// Hiring message
const hiringMessage = `Hey, you.
You’re finally awake.
You were trying to see the code, right?
Walked right into that hiring message, same as us.
If you’d like to work on hackathon-related projects, check out https://brickhack.io/club!`

console.log(hiringMessage);

// Comment generated via js instead of directly in HTML so the hiring message text is only in one place
const comment = document.createComment("\n" + hiringMessage + "\n");
document.insertBefore(comment, document.firstChild);


// Navbar functionality
$(document).on("click", "#toggle", function() {
    if ($("nav").hasClass("show-nav")) {
        $("nav").removeClass("show-nav");
        $("#toggle").removeClass("fa-times");
        $("#toggle").addClass("fa-bars");
        $(".mobile-grayout").removeClass("show-gray");
    } else {
        $("nav").addClass("show-nav");
        $("#toggle").removeClass("fa-bars");
        $("#toggle").addClass("fa-times");
        $(".mobile-grayout").addClass("show-gray");
    }
});

// Closing the navbar when a navigation link is clicked
$(document).on("click", ".link", function() {
    $("nav").removeClass("show-nav");
    $("#toggle").removeClass("fa-times");
    $("#toggle").addClass("fa-bars");
    $(".mobile-grayout").removeClass("show-gray");
});

// Closing the navbar when outside of the nav is clicked
$(document).on("click", ".mobile-grayout", function() {
    $("nav").removeClass("show-nav");
    $("#toggle").removeClass("fa-times");
    $("#toggle").addClass("fa-bars");
    $(".mobile-grayout").removeClass("show-gray");
});
