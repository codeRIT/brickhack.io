import 'react-app-polyfill/ie11';
import 'react-app-polyfill/stable';

import React from 'react';
import ReactDOM from 'react-dom';
import PreRegister from './preregister';
import 'bootstrap/dist/css/bootstrap.css';
import './index.css';

ReactDOM.render(
    <PreRegister/>,
    document.getElementById('root'),
);

