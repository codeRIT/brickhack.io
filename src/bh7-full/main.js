import React from 'react';
import { Parallax } from 'react-scroll-parallax';

var backgroundImage = require('../bh7-assets/illustration.svg');
var backgroundImageAlt = "A decorative background graphic of a monitor on a desk."

class Main extends React.Component {
    render(){
        return(
            <section id="main">
                <img id="hero-image" src={backgroundImage} alt={backgroundImageAlt}/>
                <div id="shelf"/>
            </section>
        );
    }
};

export default Main;