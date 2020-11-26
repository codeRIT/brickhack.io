import React from 'react';

class Schedule extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			selected: null,
		};
	};

	time = "10-10:30am";
	text = "Lorem ipsum dolor sit amet";
	text2 = "Bees?";

	defaultColor = "#FFFFFF";
	selectedColor = "#F2C7C1";

	componentDidMount() {
		this.setState({selected: "SATURDAY"});
	}

	changeSelected(event) {
		this.setState({selected: event});
	}

	render() {
		var saturdayColor = this.state.selected === "SATURDAY" ? this.selectedColor : this.defaultColor;
		var sundayColor = this.state.selected === "SUNDAY" ? this.selectedColor : this.defaultColor;

		var events = this.state.selected === "SATURDAY" ? 
			// saturday events
			<div className="events">
				<Event time={this.time} text={this.text}/>
				<Event time={this.time} text={this.text}/>
				<Event time={this.time} text={this.text}/>
				<Event time={this.time} text={this.text}/>
				<Event time={this.time} text={this.text}/> 
			</div>
			:
			// sunday events
			<div className="events">
				<Event time={this.time} text={this.text2}/>
				<Event time={this.time} text={this.text2}/>
				<Event time={this.time} text={this.text2}/>
				<Event time={this.time} text={this.text2}/>
				<Event time={this.time} text={this.text2}/> 
			</div>;

		return(
			<section id="schedule">
				<div className="content">
					<span className="title">
						Schedule
					</span>
					<div className="schedule">
						<div className="tape"/>
						<div className="dates">
							<Day day="20" dayName="SATURDAY" color={saturdayColor} buttonClick={this.changeSelected.bind(this, "SATURDAY")}/>
							<Day day="21" dayName="SUNDAY" color={sundayColor} buttonClick={this.changeSelected.bind(this, "SUNDAY")}/>
						</div>
						
						{events}
					</div>
				</div>
			</section>
		);
	}
};

class Day extends React.Component {
	render() {
		return(
			<button className="date" style={{color: this.props.color}} onClick={this.props.buttonClick}>
				<div className="day">
					{this.props.day}
				</div>
				<div className="day-name">
					{this.props.dayName}
				</div>
			</button>
		)
	}
}

class Event extends React.Component {
	render() {
		return(
			<div className="event">
				<div className="time">
					{this.props.time}
				</div>
				<div className="details">
					{this.props.text}
				</div>
			</div>
		);
	}
}

export default Schedule;