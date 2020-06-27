import React from 'react';
import { Button } from '@material-ui/core';

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