import React from 'react';
import './index.css';
import MailchimpInput from "./mailchimp-input.js"
import CovidPopover from "./covidpopover.js";

const PopoverStyle = {
    top: '50px'
};

var PreregisterImage = require('./preregister.svg');

class PreRegister extends React.Component {
    render() {
        return (
        <div id="app">
            <div id="fixed-container">
                <div class="desktop-banner mobile-hide" id="desktop-banner">
                        <span>COVID-19 Notice:</span> We will publish relevant information upon receiving updates from RIT and NY state.
                </div>
                    
                <div class="navigation" id="navigation">
                    <ul class="flex-container">
                        <li class="mobile-hide"><a href="https://static.mlh.io/docs/mlh-code-of-conduct.pdf">MLH CODE OF CONDUCT</a></li>
                        <li><a href="https://brickhack.io/gallery/">GALLERY</a></li>
                    </ul>
                    <a href="https://mlh.io/seasons/na-2020/events?utm_source=na-hackathon&amp;utm_medium=TrustBadge&amp;utm_campaign=2020-season&amp;utm_content=gray">
                        <img id="mlh-badge" alt="Major League Hacking 2020 Hackathon Season" src="https://s3.amazonaws.com/logged-assets/trust-badge/2020/mlh-trust-badge-2020-gray.svg"></img>
                    </a>
                </div>
            </div>

            <div class="section flex-container content">
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
                    
                    <img class="preregister-img desktop-hide" src={PreregisterImage} alt="A decorative background image."/>
        
                    <MailchimpInput/>

                    <a href="#" title="COVID-19 Notice">
                        <span class="mobile-banner desktop-hide">
                            <CovidPopover/>
                        </span>
                    </a>
                    
                    {/* We're planning BrickHack 7 to be the best and safest event possible. We will publish relevant information upon receiving updates from RIT and NY state. */}
                </div>

                <div class="right-half mobile-hide">
                    <img class="preregister-img" src={PreregisterImage} alt="A decorative background image."/>
                </div>
            </div>
        </div>
        );
    }
}

export default PreRegister;