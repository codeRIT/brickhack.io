import React, {Component} from 'react';
import './index.css';
import { OverlayTrigger, Popover, PopoverTitle, PopoverContent } from "react-bootstrap";

class CovidPopover extends Component {
    constructor(){
        super();
        this.state = {
            name: "react",
            popoverOpen: false,
        };
        this.togglePopover = this.togglePopover.bind(this);
    }

    togglePopover() {    
        this.setState({ popoverOpen: !this.state.popoverOpen })  
      }
      
      render() {
          const { popoverOpen } = this.state;
          return (
              <OverlayTrigger
                trigger="click"
                placement="top"
                show={true}
                overlay={
                    <Popover id="popover-basic" >
                        <PopoverTitle as="h3">COVID-19 Notice</PopoverTitle>
                        <PopoverContent>
                            We will publish relevant information upon receiving updates from RIT and NY state.
                        </PopoverContent>
                    </Popover>
                    }
                >
                <a href="#" id="mypopover">
                    COVID-19 Notice
                </a>
              </OverlayTrigger>
          );
      }
}


export default CovidPopover;