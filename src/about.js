import React from 'react';
import Slider from "react-slick";
import "slick-carousel/slick/slick.css"; 
import "slick-carousel/slick/slick-theme.css";


class About  extends React.Component {
    render() {
        const settings = {
            infinite: true,
            speed: 500,
            swipeToSlide: true,
            arrows: true,
            variableWidth: true,
            className: 'slides',
        };
        return(
            <section id="about">
                    <div className ="wire"></div>
                    <Slider {...settings}>
                        <div>
                        </div>
                        <div>
                        </div>
                        <div>
                        </div>
                        <div>
                        </div>
                        <div>
                        </div>
                        <div>
                        </div>
                    </Slider>
                    <div class="content">
                        <div id="header">
                            <h2 id="title">What is a Hackathon?</h2>
                        </div>
                        <div id= "para">
                            <p>A Hackathon is an invention marathon. Any student can attend! Really, any student... 
                                and it's completely free.</p>
                            <br></br>
                            <p>Students work in teams and mentors are present to offer help.
                                Sponsors attend to help, recruit, and promote their products. 
                                Teams compete in different categories and prizes are awarded, but everyone learns and everyone wins!</p>
                            <br></br>
                            <p>Come spend 24 hours with us at BrickHack and dedicate time to learn, collaborate, build, and innovate.</p>
                        </div>
                    </div>
                    {/* <div className="buttons">
                        <div className= "blue_box" id ="community_box">
                                <div className ="arrow_orange"></div>
                                <div className ="line orange_line"></div> 
                            <div className="text-box" id="comm_text">
                                <p>Connect with the BrickHack community</p></div>
                        </div>
                        <div className ="blue_box" id ="MLH_box">
                                <div className ="arrow_red"></div>
                                <div className ="line red_line"></div> 
                            <div className="text-box" id="MLH_text">
                                <p>Visit Major League Hacking (MLH)</p>
                            </div>
                        </div>
                    </div> */}
            </section>
        );
    }
};

export default About;
