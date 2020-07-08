import React from 'react';
import NavBar from "./nav-bar.js";
import MailchimpInput from "./mailchimp-input.js";
import CovidPopover from "./covid-popover.js";

var HeroImage = require('./hero.svg');

var desktopNotice = "COVID-19 Notice: "
var mobileNotice = "COVID-19 Notice"
var noticeContent = "We're planning BrickHack 7 to be the best and safest event possible. We will publish relevant information upon receiving updates from RIT and NY State."

class PreRegister extends React.Component {
    render() {
        return (
        <div id="app">
            <div className="full-height">
                <NavBar 
                    title={desktopNotice}
                    content={noticeContent}
                />

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

                        <CovidPopover 
                            title={mobileNotice}
                            content={noticeContent}
                        />
                        
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