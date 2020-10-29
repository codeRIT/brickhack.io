/* eslint-disable jsx-a11y/anchor-is-valid */

import React from 'react';

class Nav extends React.Component {
    /*
    componentDidMount(){
        var fixedContainer = document.getElementsByTagName("nav")[0];
        var children = Array.from(fixedContainer.children);

        children.forEach(child => {
            var clone = child.cloneNode(true);
            clone.removeAttribute("id");
            clone.style.visibility = "hidden";
            clone.classList.add("desktop-hide");
            
            child.style.position = "fixed";

            fixedContainer.append(child);
            fixedContainer.append(clone);
        });
    }
    */

    render(){
        return(
            <nav>
                <ul>
                    <img id="logo" alt="BrickHack Logo"/>
                    <a href=""><li>GENERAL</li></a>
                    <a href="/#about"><li>ABOUT</li></a>
                </ul>

                <a href="https://mlh.io/seasons/na-2021/events?utm_source=na-hackathon&amp;utm_medium=TrustBadge&amp;utm_campaign=2020-season&amp;utm_content=gray">
                    <img id="mlh-badge" alt="Major League Hacking 2021 Hackathon Season" src="https://s3.amazonaws.com/logged-assets/trust-badge/2021/mlh-trust-badge-2021-gray.svg"></img>
                </a>
            </nav>
        );
    }
};

export default Nav;