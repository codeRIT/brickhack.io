import React from 'react';
import NavBar from "./nav-bar.js";
import MailchimpInput from "./mailchimp-input.js";
import CovidPopover from "./covid-popover.js";

var HeroImage = require('./hero.svg');

class PreRegister extends React.Component {
    render() {
        return (
        <div id="app">
            <NavBar/>

            <div class="full-height">
                <div class="section flex-container">
                    <div class="left-half">
                        <div id="hackathon-name">
                            BRICKHACK 7
                        </div>
                        <div id="hackathon-description">
                            RIT's Premiere Hackathon
                        </div>                        
                        <div id="hackathon-info">
                            Feb 20-21 | ROCHESTER INSTITUTE OF TECHNOLOGY
                        </div>
                        
                        <img class="hero-img desktop-hide" src={HeroImage} alt="A decorative background image."/>
            
                        <MailchimpInput/>

                        <div class="mobile-banner desktop-hide">
                            <CovidPopover/>
                        </div>
                    </div>

                    <div class="right-half mobile-hide">
                        <img class="hero-img" src={HeroImage} alt="A decorative background image."/>
                    </div>
                </div>
            </div>

        </div>
        );
    }
}

export default PreRegister;