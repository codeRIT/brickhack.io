<<<<<<< HEAD
//import React from 'react';
//import { Button } from '@material-ui/core';
=======
/*import React from 'react';
import { Button } from '@material-ui/core';*/
>>>>>>> 5a90a607646d5733313c86a8dcfce174887940cf

window.onscroll = function() {myFunction()};

var navbar = document.getElementById("navbar");

var sticky = navbar.offsetTop;

function myFunction() {
    if (window.pageYOffset >= sticky) {
        navbar.classList.add("sticky")                                              lassList.add("sticky");
    } else {
        navbar.classList.remove("sticky");
    }
}
/*
Vue.component('hackathon-button', {
    data: function () {
      return {
        count: 0
      }
    },
    template: '<Button color="primary">Hello World</Button>'  
})

var app = new Vue({
    el: '#app',
    data: {
    },
<<<<<<< HEAD
})*/
=======
})

/* for elements fixed at the top

elements under fixed-container will have their position set to fixed (banner, nav bar)
fixed elements don't take up space, so it creates creates hidden, unfixed copies of these elements 
these hidden elements will take up the space that they *should* take*/

var fixedContainer = document.getElementById("fixed-container");
var children = Array.from(fixedContainer.children);

children.forEach(child => {
    var clone = child.cloneNode(true);
    clone.removeAttribute("id");
    clone.style.visibility = "hidden";

    child.style.position = "fixed";

    fixedContainer.append(child);
    fixedContainer.append(clone);
});
>>>>>>> 5a90a607646d5733313c86a8dcfce174887940cf
