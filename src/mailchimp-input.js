import React from 'react';
import {makeStyles} from '@material-ui/core/styles';

class CovidPopover extends React.Component {
    render(){
        return(
            <div class="input-container flex-container">
                <input class="mailchimp-input" placeholder="enter your email to stay updated"/>
                <button class="mailchimp-button"/>
            </div>
        );
    }
};

export default CovidPopover;