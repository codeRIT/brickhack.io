/*import React from 'react';
import { Button } from '@material-ui/core';*/

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