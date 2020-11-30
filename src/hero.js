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
                    <form action="https://coderit.us11.list-manage.com/subscribe/post?u=122b09a8cef4c1f3888af8e40&amp;id=4c1af7f783" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" className="validate" target="_blank">
                        <div className="mailchimp-container">
                            <input type="email" name="EMAIL" className="mailchimp-input" placeholder="enter your email to stay updated" required/>
                            <input type="submit" value="" name="subscribe" id="mc-embedded-subscribe" className="mailchimp-button"/>

                            {/* real people should not fill this in and expect good things - do not remove this or risk form bot signups*/}
                            <div style={{position: "absolute", left: "-20000px", ariaHidden: "true"}}><input type="text" name="b_122b09a8cef4c1f3888af8e40_4c1af7f783" tabIndex="-1"/></div>
                        </div>
                    </form>
                </div>
            </section>
        );
    }
};

export default Hero;
