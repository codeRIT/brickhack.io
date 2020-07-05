import React from 'react';

class NavBar extends React.Component {
    componentDidMount() {
        var fixedContainer = document.getElementById("fixed-container");
        var children = Array.from(fixedContainer.children);

        children.forEach(child => {
            var clone = child.cloneNode(true);
            clone.removeAttribute("id");
            clone.style.visibility = "hidden";

            child.style.position = "fixed";

            fixedContainer.append(child);
            fixedContainer.append(clone);
        });
    }
    render(){
        return(
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
        );
    }
};

export default NavBar;