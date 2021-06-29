import './sass/index.scss'

import { AniX } from 'anix'

const $ = require('jquery')
window.$ = window.jQuery = $
require("jquery-ui-bundle")

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

// Secret messages
const revertDuration = 300
var messageIndex = 0
const messages = [
    "Like, really, nothing to see here.",
    "Hey. Stop looking.",
    "Hey. Stop looking.",
    "...",
    "I'm warning you...",
    "There's really nothing.",
    "There's really nothing.",
    "There's really nothing.",
    "...",
    "Wow, you just don't want to believe me.",
    "What have I ever done to you?!",
    "...",
    "Oh, right...",
    "...the bricks...",
    "...",
    "Yeah, that was... my bad.",
    "Life's hard as a rockstar, you know?",
    "I'm really a brickstar, actually.",
    "... leader of ThunderClan? I don't get the reference.",
    "Have you heard my new song?",
    "It goes like,",
    "I'm bringin' Ricky Back! (yeah)",
    "(barrrw) Them other boys don't know--",
    "I'M BRINGIN' RICKY BACK (yeah)",
    "It's a bop, if I do say so myself.",
    "Oh, by the way Dave,",
    "We're contacting you about your car's extended warrany...",
    "Haha, just kidding.",
    "I have some brick business to get back to.",
    "You know how it is.",
    "I do have a tip for you though.",
    "When you sign up for BrickHack...",
    "...make sure to ask if you need your own bricks.",
    "Heh. Gets them every year.",
    "Well, see ya!",
    "(the wall is quiet.)",
    "(it fills you with determination.)",
    ""
]


$(document).ready(function() {
    $(".window").draggable({
        cursor: "grab",
        revert: true,
        revertDuration: revertDuration,
        handle: ".title-bar",
        // Adjust scale factor of page to match mouse dragging position
        drag: function(event, ui) {
            ui.position.top = Math.round(ui.position.top / 1.5)
            ui.position.left = Math.round(ui.position.left / 1.5)
        }
    });
})

$(".window-control").click(function() {
    $(".window").css({"visibility": "hidden"});
})

$(".title-bar").mouseup(function() {
    // Don't show the message before the window returns to its original position
    setTimeout(function() {
        const offset = $(".window").position()
        updateSecretMessage(offset)
    }, revertDuration)
})

function updateSecretMessage(offset) {
    // TODO: Make sure the window was dragged enough to see the message
    // so the user has less chance of missing it before we refresh.

    $("#secret-message").text(messages[messageIndex])
    messageIndex++
}
