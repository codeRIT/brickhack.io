  
import React from 'react';

class Schedule extends React.Component {

    time = "10-10:30am"
    text = "Lorem ipsum dolor sit amet";

    render() {
        return(
            <section id="schedule">
                <div class="content">
                    <span class="title">
                        Schedule
                    </span>
                    <div class="schedule">
                        <div class="tape"/>
                        <div class="dates">
                            <div class="date">
                                <div class="day">
                                    20
                                </div>
                                <div class="day-name">
                                    SATURDAY
                                </div>
                            </div>
                            <div class="date">
                                <div class="day">
                                    21
                                </div>
                                <div class="day-name">
                                    SUNDAY
                                </div>
                            </div>
                        </div>
                        <div class="events">
                            <Event time={this.time} text={this.text}/>
                            <Event time={this.time} text={this.text}/>
                            <Event time={this.time} text={this.text}/>
                            <Event time={this.time} text={this.text}/>
                            <Event time={this.time} text={this.text}/>
                        </div>
                    </div>
                </div>
            </section>
        );
    }
};

class Event extends React.Component {
    render() {
        return(
            <div class="event">
                <div class="time">
                    {this.props.time}
                </div>
                <div class="details">
                    {this.props.text}
                </div>
            </div>
        );
    }
}

export default Schedule;