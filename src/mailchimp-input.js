import React from 'react';
import {makeStyles} from '@material-ui/core/styles';

export default function MailchimpInput() {
    return(
        <div class="input-container flex-container">
            <input class="mailchimp-input" placeholder="enter your email to stay updated"/>
            <button class="mailchimp-button"/>
        </div>
    );
};