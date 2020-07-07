import React from 'react';
import NavBar from "./nav-bar.js";
import MailchimpInput from "./mailchimp-input.js";
import CovidPopover from "./covid-popover.js";

var HeroImage = require('./hero.svg');

class PreRegister extends React.Component {
    render() {
        return (
        <div id="app">
            <div className="full-height">
                <NavBar/>
                <div className="section flex-container">
                    <div className="left-half">
                        <div id="hackathon-name">
                            BRICKHACK 7
                        </div>
                        <div id="hackathon-description">
                            RIT's Premiere Hackathon
                        </div>                        
                        <div id="hackathon-info">
                            Feb 20-21 | ROCHESTER INSTITUTE OF TECHNOLOGY
                        </div>
                        
                        <img className="hero-img desktop-hide" src={HeroImage} alt="A decorative background hero graphic."/>
            
                        <MailchimpInput/>

                        <CovidPopover/>
                    </div>

                    <div className="right-half mobile-hide">
                        <img className="hero-img" src={HeroImage} alt="A decorative background hero graphic."/>
                    </div>
                </div>
            </div>

        </div>
        );
    }
}

export default PreRegister;