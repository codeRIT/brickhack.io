import React from 'react';

import Nav from "./nav.js";
import General from './general.js'
import About from './about.js'

class Site extends React.Component {
    render() {
        return (
        <div id="app">
            <Nav/>
            <General/>
            <About/>
        </div>
        );
    }
}

export default Site;