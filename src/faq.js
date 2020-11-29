import React from 'react';

class FAQ extends React.Component {

	placeholderQuestion = "Who can Participate in Brickhack?";
	placeholderText = "Anyone currently enrolled as a student can attend! If you don't fit that description,you're absolutely welcome to attend as a mentor or volunteer. All attendees must be 18 years or older."

	render() {
		return(
			<section id="faq">
				<h1>Frequently Asked Questions</h1>
				<div class="content">
					<div class="column">
						<Accordion question={this.placeholderQuestion} content={this.placeholderText}/>
						<Accordion question={this.placeholderQuestion} content={this.placeholderText}/>
						<Accordion question={this.placeholderQuestion} content={this.placeholderText}/>
					</div>
					<div class="column">
						<Accordion question={this.placeholderQuestion} content={this.placeholderText}/>
						<Accordion question={this.placeholderQuestion} content={this.placeholderText}/>
						<Accordion question={this.placeholderQuestion} content={this.placeholderText}/>
					</div>
					<p> Don't see your question here? Feel free to <a href="url">Contact Us</a></p>
				</div>
			</section>
		);
	}
};

class Accordion extends React.Component {
	render() {
		return (
			<div class="dropcontent">
				<button type="button" class="dropbutton">
					Who can Participate in Brickhack?
				</button>
				<p>
					{this.props.content}
				</p>
			</div>
		);
	}
}

export default FAQ;
