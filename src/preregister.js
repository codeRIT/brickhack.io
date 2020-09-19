import React from 'react';
import NavBar from "./nav-bar.js";
import MailchimpInput from "./mailchimp-input.js";
import CovidPopover from "./covid-popover.js";

var heroImage = require('./hero.svg');
var heroImageAlt = "A decorative hero graphic."

var noticeContent = "We're planning for BrickHack 7 to be the best and safest event possible. We will publish relevant information upon receiving updates from RIT and NY State."

class PreRegister extends React.Component {
    render() {
        return (
        <div id="app">
            <NavBar 
                content={noticeContent}
            />

            <div className="section">
                <div className="content flex-container">
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
                        <img className="hero-img desktop-hide" src={heroImage} alt={heroImageAlt}/>
                        <MailchimpInput/>

                        <div id="contact" className="mobile-hide">
                            <p>Interested in Sponsoring?</p>
                            <p><a href="mailto:sponsorship@coderit.org">sponsorship@coderit.org</a></p>
                        </div>

                        <CovidPopover 
                            content={noticeContent}
                        />
                    </div>

                    <div className="right-half mobile-hide">
                        <img className="hero-img mobile-hide" src={heroImage} alt={heroImageAlt}/>
                    </div>
                </div>
            </div>
        </div>
        );
    }
}

export default PreRegister;