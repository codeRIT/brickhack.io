import './sass/gallery.scss'
import '@fortawesome/fontawesome-free/css/all.css'

// Navbar functionality
var navlinks = document.getElementsByClassName("navlinks");
var toggler = document.getElementsByClassName("fa-bars")[0];
toggler.addEventListener("click", function() {
    if (navlinks[0].className === "navlinks") {
        for (var i = 0; i < navlinks.length; i++) {
            navlinks[i].className = "navlinks show-menu";
        }
        toggler.className = "fas fa-times";
    } else {
        for (var i = 0; i < navlinks.length; i++) {
            navlinks[i].className = "navlinks";
        }
        toggler.className = "fas fa-bars";
    }
});
// Closing the navbar when a navigation link is clicked
for (var i = 0; i < navlinks.length; i++) {
    navlinks[i].addEventListener("click", function() {
        if (navlinks[0].className === "navlinks show-menu") {
            for (var i = 0; i < navlinks.length; i++) {
                navlinks[i].className = "navlinks";
            }
            toggler.className = "fas fa-bars";
        }
    });
}
