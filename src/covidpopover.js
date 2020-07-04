import React from 'react';
import './index.css';
import { Box, Button, Popover, Typography } from '@material-ui/core';
import PopupState, {bindTrigger, bindPopover} from 'material-ui-popup-state';

export default function CovidPopover() {
    return (
        <PopupState variant="popover" popupId="demo-popup-popover">
            {(popupState) => (
                <div>
                <a variant="contained" color="primary" {...bindTrigger(popupState)}>
                    COVID-19 Notice
                </a>
                <Popover
                    {...bindPopover(popupState)}
                    anchorOrigin={{
                    vertical: 'top',
                    horizontal: 'center',
                    }}
                    transformOrigin={{
                    vertical: 'top',
                    horizontal: 'center',
                    }}
                >
                    <Box p={2}>
                    <Typography>We're planning BrickHack 7 to be the best and safest event possible. We will publish relevant information upon receiving updates from RIT and NY state.</Typography>
                    </Box>
                </Popover>
                </div>
            )}
        </PopupState>
    );
};