import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import MainRoutes from './routes';

ReactDOM.render(
    <MainRoutes />,
    document.getElementById('root')
);

var fixedContainer = document.getElementById("fixed-container");
var children = Array.from(fixedContainer.children);

children.forEach(child => {
    var clone = child.cloneNode(true);
    clone.removeAttribute("id");
    clone.style.visibility = "hidden";

    child.style.position = "fixed";

    fixedContainer.append(child);
    fixedContainer.append(clone);
});
