import React from 'react';
import { Button } from '@material-ui/core';

Vue.component('Button', {
    data: function () {
      return {
        count: 0
      }
    },
    template: 'SSSS<Button color="primary">Hello World</Button>'  
})

var app = new Vue({
    el: '#app',
    data: {
        info: 'hello!',
    },
})