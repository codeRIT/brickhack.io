//import React from 'react';
//import { Button } from '@material-ui/core';

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
})*/