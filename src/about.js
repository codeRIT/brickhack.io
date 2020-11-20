import React from 'react';
import Slider from "react-slick";
import "slick-carousel/slick/slick.css"; 
import "slick-carousel/slick/slick-theme.css";


class About  extends React.Component {
    render() {
        const settings = {
            dots: false,
            infinite: true,
            speed: 500,
            slidesToShow: 4,
            slidesToScroll: 1,
            swipeToSlide: true,
            arrows: true,
            className: 'slides'
        };
        return(
            <section id="about">
                    <div className ="wire"></div>
                    <Slider {...settings}>
                        <div>
                            <h3>1</h3>
                        </div>
                        <div>
                            <h3>2</h3>
                        </div>
                        <div>
                            <h3>3</h3>
                        </div>
                        <div>
                            <h3>4</h3>
                        </div>
                        <div>
                            <h3>5</h3>
                        </div>
                        <div>
                            <h3>6</h3>
                        </div>
                    </Slider>
                    <div id="header">
                        <h2 id="title">What is a Hackathon?</h2>
                    </div>
                    <div id= "para">
                        <p>A Hackathon is an invention marathon. Any student can attend! Really, any student... 
                            and it's completely free.</p>

                        <p>Students work in teams and mentors are present to offer help.
                             Sponsors attend to help, recruit, and promote their products. 
                             Teams compete in different categories and prizes are awarded, but everyone learns and everyone wins!</p>

                        <p>Come spend 24 hours with us at BrickHack and dedicate time to learn, collaborate, build, and innovate.</p>
                    </div>
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
                            <p>Visit Major League Hacking (MLH)</p></div>
                    </div>
            </section>
        );
    }
};

export default About;
