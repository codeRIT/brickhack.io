import React from 'react';

class Hero extends React.Component {
    render() {
        return(
            <section id="hero">
                <div id="wire" className="desktop-hide"/>
                <div id="hero-content">
                    <div id="hackathon-name">
                        BRICKHACK 7
                    </div>
                    <div id="hackathon-description">
                        RIT's Premiere Hackathon
                    </div>
                    <div id="hackathon-info">
                        Feb 20-21 | ROCHESTER INSTITUTE OF TECHNOLOGY
                    </div>
                    <a href="https://apply.brickhack.io/users/sign_up" id="register">REGISTER</a>
                </div>
            </section>
        );
    }
};

export default Hero;
