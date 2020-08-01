import React from 'react';
import ReactDOM from 'react-dom';
import PreRegister from './preregister';
import 'bootstrap/dist/css/bootstrap.css';
import './index.scss';

console.log("Interested in getting further involved?\n"+
"codeRIT is looking for developers, come and join us at https://coderit.org/!");

ReactDOM.render(
    <PreRegister/>,
    document.getElementById('root'),
);
