import React from 'react';

import Nav from "./nav.js";
import Main from './main.js'
import About from './about.js'

class Site extends React.Component {
    render() {
        return (
        <div id="app">
            <Nav/>
            <Main/>
            <About/>
        </div>
        );
    }
}

export default Site;