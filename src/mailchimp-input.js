import React from 'react';

class CovidPopover extends React.Component {
    render(){
        return(
            <form action="https://coderit.us11.list-manage.com/subscribe/post?u=122b09a8cef4c1f3888af8e40&amp;id=4c1af7f783" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
                <div class="input-container flex-container">
                    <input type="email" name="EMAIL" class="mailchimp-input" placeholder="enter your email to stay updated" required/>
                    
                    {/* real people should not fill this in and expect good things - do not remove this or risk form bot signups*/}
                    <div style={{position: "absolute", left: "-5000px", ariaHidden: "true"}}><input type="text" name="b_122b09a8cef4c1f3888af8e40_4c1af7f783" tabindex="-1" value=""/></div>                        <input type="submit" value="" name="subscribe" id="mc-embedded-subscribe" class="mailchimp-button"/>
                </div>
            </form>
        );
    }
};

export default CovidPopover;