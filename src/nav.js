/* eslint-disable jsx-a11y/anchor-is-valid */

import React from 'react';

class Nav extends React.Component {
    render() {
        return(
            <nav>
                <div class="links mobile-hide">
                    <img id="logo" alt="BrickHack Logo"/>
                    <a href="#hero"><li>GENERAL</li></a>
                    <a href="#about"><li>ABOUT</li></a>
                </div>
                <div class="login-and-banner">
                    <a href="https://apply.brickhack.io/" id="login">LOGIN</a>
                    <a href="https://mlh.io/seasons/na-2021/events?utm_source=na-hackathon&amp;utm_medium=TrustBadge&amp;utm_campaign=2020-season&amp;utm_content=gray">
                        <img id="mlh-badge" alt="Major League Hacking 2021 Hackathon Season" src="https://s3.amazonaws.com/logged-assets/trust-badge/2021/mlh-trust-badge-2021-gray.svg"></img>
                    </a>
                </div>

            </nav>
        );
    }
};

export default Nav;
