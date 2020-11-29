import React from 'react';

class FAQ extends React.Component {

	placeholderQuestion = "Who can participate in Brickhack?";
	placeholderText = "Anyone currently enrolled as a student can attend! If you don't fit that description,you're absolutely welcome to attend as a mentor or volunteer. All attendees must be 18 years or older."

	render() {
		return(
			<section id="faq">
				<div className="content">
					<h1 className="title">
						Frequently Asked Questions
					</h1>
					<div className="accordion-columns">
						<div className="accordion-column">
							<Accordion question={this.placeholderQuestion} answer={this.placeholderText}/>
							<Accordion question={this.placeholderQuestion} answer={this.placeholderText}/>
							<Accordion question={this.placeholderQuestion} answer={this.placeholderText}/>
						</div>
						<div className="accordion-column">
							<Accordion question={this.placeholderQuestion} answer={this.placeholderText}/>
							<Accordion question={this.placeholderQuestion} answer={this.placeholderText}/>
							<Accordion question={this.placeholderQuestion} answer={this.placeholderText}/>
						</div>
					</div>
					<p>Don't see your question here? <a href="#jk">CONTACT US</a></p>
				</div>
			</section>
		);
	}
};

class Accordion extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			selected: false,
		};
	};

	componentDidMount() {
		this.setState({selected: false});
	}

	toggleSelected() {
		this.setState({selected: !this.state.selected});
	}

	render() {
		var accordionClasses = "accordion";

		if (this.state.selected) {
			accordionClasses = "accordion selected";
		}

		var accordion = <div className={accordionClasses} onClick={this.toggleSelected.bind(this)}>
			<i className="fas fa-plus"></i>
			<div className="text">
				<h5 className="question">
					{this.props.question}
				</h5>
				<p className="answer">
					{this.props.answer}
				</p>
			</div>
		</div>;

		return (
			accordion
		);
	}
}

export default FAQ;
