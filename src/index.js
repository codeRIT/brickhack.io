import React from 'react';
import ReactDOM from 'react-dom';
import PreRegister from './preregister';
import 'bootstrap/dist/css/bootstrap.css';
import './index.scss';

console.log(`Hey, you.\n
You’re finally awake.\n
You were trying to see the code, right?\n
Walked right into that hiring message, same as us.\n
If you’d like to work on this website and other cool projects with hackathons, send an email over to engineering@coderit.edu!`);

ReactDOM.render(
    <PreRegister/>,
    document.getElementById('root'),
);
