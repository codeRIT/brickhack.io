import React from 'react';

class MailchimpInput extends React.Component {
    componentDidMount(){
        var form = document.getElementById("mc-embedded-subscribe-form");
        form.novalidate = true;
    }
    render(){
        return(
            <form action="https://coderit.us11.list-manage.com/subscribe/post?u=122b09a8cef4c1f3888af8e40&amp;id=4c1af7f783" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" className="validate" target="_blank">
                <div className="mailchimp-container flex-container">
                    <input type="email" name="EMAIL" className="mailchimp-input" placeholder="enter your email to stay updated" required/>
                    <input type="submit" value="" name="subscribe" id="mc-embedded-subscribe" className="mailchimp-button"/>

                    {/* real people should not fill this in and expect good things - do not remove this or risk form bot signups*/}
                    <div style={{position: "absolute", left: "-5000px", ariaHidden: "true"}}><input type="text" name="b_122b09a8cef4c1f3888af8e40_4c1af7f783" tabIndex="-1"/></div>
                </div>
            </form>
        );
    }
};

class General extends React.Component {
    render(){
        return(
            <section id="general">
                <div id="content">
                    <div id="hackathon-name">
                            BRICKHACK 7
                    </div>
                    <div id="hackathon-description">
                            RIT's Premiere Hackathon
                    </div>
                    <div id="hackathon-info">
                            Feb 20-21 | ROCHESTER INSTITUTE OF TECHNOLOGY
                    </div>
                    <MailchimpInput/>
                </div>
                {/*<img id="hero-image" src={backgroundImage} alt={backgroundImageAlt}/>*/}
                <div id="shelf"/>
            </section>
        );
    }
};

export default General;