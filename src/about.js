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
                    <div class="wire"></div>
                    <img src={require("./bh7-assets/clip.svg")}/>
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
                        <h2>What is a Hackathon?</h2>
                        <br></br>
                        <p>A Hackathon is an invention marathon. Any student can attend! Really, any student...
                            and it's completely free.</p>
                        <br></br>
                        <p>Students work in teams and mentors are present to offer help.
                            Sponsors attend to help, recruit, and promote their products.
                            Teams compete in different categories and prizes are awarded, but everyone learns and everyone wins!</p>
                        <br></br>
                        <p>Come spend 24 hours with us at BrickHack and dedicate time to learn, collaborate, build, and innovate.</p>
                    </div>
                    <div class="buttons-container">
                        {/* <a href =""><div class="blue_box" id="community_box">
                                <div class ="arrow_orange"></div>
                                <div class ="line orange_line"></div>
                            <div class="text-box">
                                <p>Connect with the BrickHack community</p>
                            </div>
                        </div>
                        </a> */}
                        <a href ="https://mlh.io/" target = "_blank"><div class="blue_box" id="MLH_box">
                                <div class="arrow_red"></div>
                                <div class="line red_line"></div>
                            <div class="text-box">
                                <p>Visit Major League Hacking (MLH)</p>
                            </div>
                        </div>
                        </a>
                    </div>
            </section>
        );
    }
};

export default About;
