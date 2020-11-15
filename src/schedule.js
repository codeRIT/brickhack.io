  
import React from 'react';

class Schedule extends React.Component {
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
                                <div class="weekday">
                                    SATURDAY
                                </div>
                            </div>
                            <div class="date">
                                <div class="day">
                                    21
                                </div>
                                <div class="weekday">
                                    SUNDAY
                                </div>
                            </div>
                        </div>
                        <div class="events">
                            <Event/>
                            <Event/>
                            <Event/>
                            <Event/>
                            <Event/>
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
                    10-10:30am
                </div>
                <div class="details">
                    Lorem ipsum dolor sit amet
                </div>
            </div>
        );
    }
}

export default Schedule;