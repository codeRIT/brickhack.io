import React from 'react';
import ReactDOM from 'react-dom';
import Site from './site';

import 'bootstrap/dist/css/bootstrap.css';
import './index.scss';

const hiringMessage = `Hey, you.
You’re finally awake.
You were trying to see the code, right?
Walked right into that hiring message, same as us.
If you’d like to work on this website and other cool projects with hackathons, send an email over to engineering@coderit.org!`

console.log(hiringMessage);

//comment generated via javascript instead of in HTML so the hiring message text is only in one place
const comment = document.createComment("\n"+hiringMessage.toString()+"\n");
document.insertBefore(comment, document.firstChild);

ReactDOM.render(
    <Site/>,
    document.getElementById('root'),
);
