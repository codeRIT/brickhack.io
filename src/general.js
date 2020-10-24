import React from 'react';

var backgroundImage = require('./bh7-assets/hero.svg');
var backgroundImageAlt = "A decorative background graphic of a monitor on a desk."

class General extends React.Component {
    render(){
        return(
            <section id="general">
                <img id="hero-image" src={backgroundImage} alt={backgroundImageAlt}/>
                <div id="shelf"/>
            </section>
        );
    }
};

export default General;