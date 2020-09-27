import React from 'react';

import Main from './main.js'
import About from './about.js'

class Site extends React.Component {
    render() {
        return (
        <div id="app">
            <Main/>
            <About/>
        </div>
        );
    }
}

export default Site;