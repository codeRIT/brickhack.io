import React from 'react';

class About extends React.Component {
  render() {
    return(
      <section id="faq">
        <h1>Frequently Asked Questions</h1>
        <div class="content">
          <div class="column">
            <div id="participate" class="dropcontent">
              <button type="button" class="dropbutton">Who can Participate in Brickhack?</button>
              <p>
                  Anyone currently enrolled as a student can attend! If you don't fit that description,
                  you're absolutely welcome to attend as a mentor or volunteer. All attendees must be
                  18 years or older.
              </p>
            </div>
            <div id="team" class="dropcontent">
              <button type="button" class="dropbutton">Do I need a team to join?</button>
              <p>
                  Anyone currently enrolled as a student can attend! If you don't fit that description,
                  you're absolutely welcome to attend as a mentor or volunteer. All attendees must be
                  18 years or older.
              </p>
            </div>
            <div id="bring" class="dropcontent">
              <button type="button" class="dropbutton">What should I bring?</button>
              <p>
                Anyone currently enrolled as a student can attend! If you don't fit that description,
                you're absolutely welcome to attend as a mentor or volunteer. All attendees must be
                18 years or older.
              </p>
            </div>
          </div>
          <div class="column">
            <div id="apply" class="dropcontent">
              <button type="button" class="dropbutton">Do RIT students need to apply?</button>
              <p>
                Anyone currently enrolled as a student can attend! If you don't fit that description,
                you're absolutely welcome to attend as a mentor or volunteer. All attendees must be
                18 years or older.
              </p>
            </div>
            <div id="gotin" class="dropcontent">
              <button type="button" class="dropbutton">When will I know if I got in?</button>
              <p>
                Anyone currently enrolled as a student can attend! If you don't fit that description,
                you're absolutely welcome to attend as a mentor or volunteer. All attendees must be
                18 years or older.
              </p>
            </div>
            <div id="bricks" class="dropcontent">
              <button type="button" class="dropbutton">Should I bring my own bricks...</button>
              <p>
                Anyone currently enrolled as a student can attend! If you don't fit that description,
                you're absolutely welcome to attend as a mentor or volunteer. All attendees must be
                18 years or older.
              </p>
            </div>
          </div>
          <p> Don't see your question here? Feel free to <a href="url">Contact Us</a></p>
        </div>
      </section>
    );
  }
};

export default About;
