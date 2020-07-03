import React from 'react';
import './index.css';
import PreregisterImage from './preregister.svg';
import { ReactSVG } from 'react-svg';

class PreRegister extends React.Component {    
    render() {
        return (
        <div id="app">
            <div id="fixed-container">
                <div class="desktop-banner mobile-hide" id="desktop-banner">
                    <span>COVID-19 Notice:</span> We're planning BrickHack 7 to be the best and safest event possible. We will publish relevant information upon receiving updates from RIT and NY state.
                    </div>
                <div class="nav" id="nav">
                    <ul class="flex-container">
                        <li class="mobile-hide">MLH CODE OF CONDUCT</li>
                        <li>GALLERY</li>
                        <li>SPONSOR US</li>
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
                        2021 Brick City's Premiere Hackathon
                    </div>                        
                    <div id="hackathon-info">
                        Feb 20-21 | ROCHESTER INSTITUTE OF TECHNOLOGY
                    </div>

                    <ReactSVG class="preregister-img desktop-hide" src="{PreregisterImage}" alt="A decorative background image."/>
                    
                    <div class="input-container flex-container">
                        <input class="hackathon-input" placeholder="enter your email to stay updated"/>
                    </div>

                    <a href="#" title="COVID-19 Notice" data-toggle="popover" data-placement="top" data-content="Content">
                        <span class="mobile-banner desktop-hide">COVID-19 Notice</span>
                    </a>
                </div>

                <div class="right-half mobile-hide">
                    <ReactSVG class="preregister-img" src="{PreregisterImage}" alt="A decorative background image."/>
                </div>
            </div>
        </div>
        );
    }
}

export default PreRegister;