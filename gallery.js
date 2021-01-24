import './sass/gallery.scss'
import '@fortawesome/fontawesome-free/css/all.css'

import $ from 'jquery'

var AWS = require('aws-sdk');

// Getting images onto the page
var albumBucketName = 'brickhack-gallery';
// Credentials
AWS.config.update({
    region: 'us-east-1',
    credentials: new AWS.CognitoIdentityCredentials({
        IdentityPoolId: '',
    })
});
// Service Object
var s3 = new AWS.S3({
    apiVersion: '2006-03-01',
    params: {Bucket: albumBucketName}
});
viewAlbum('bh6');
// Used to create HTML for our images
function getHtml(template) {
    return template.join('\n');
}
function viewAlbum(albumName) {
    var albumPhotosKey = encodeURIComponent(albumName) + '/full/';
    s3.listObjects({Prefix: albumPhotosKey}, function(err, data) {
        if (err) {
            return alert('Oopsie! There was an error viewing ' + albumName + ': ' + err.message);
        }

        var href = this.request.httpRequest.endpoint.href;
        var bucketUrl = href + albumBucketName + '/';

        var photos = data.Contents.map(function(photo) {
            var photoKey = photo.Key;
            var photoUrl = bucketUrl + encodeURIComponent(photoKey);
            return getHtml([
                '<div class="image" style="background-image: url(' + photoUrl + ');"></div>',
            ]);
        });
        document.getElementById(albumName).innerHTML = getHtml(photos);
    });
}

// Opening modal
$(document).on('click', function(event) {
    if ($(event.target).attr('class') == 'image') {
        $('#modal').show();
        var top = 'calc(5% + ' + (window.scrollY) + 'px)';
        $('#modal').css('top', top);
        $('#modal-background').show();
    }
});

// Closing modal with x
$('#close-modal').on('click', function() {
    $('#modal').hide();
    $('#modal-background').hide();
});

// Closing modal with background
$('#modal-background').on('click', function() {
    $('#modal').hide();
    $('#modal-background').hide();
});

// Navbar functionality
$(document).on('click', '#toggler', function() {
    if ($('.navlinks').hasClass('show-menu')) {
        $('.navlinks').removeClass('show-menu');
        $('#toggler').removeClass('fa-times');
        $('#toggler').addClass('fa-bars');
    } else {
        $('.navlinks').addClass('show-menu');
        $('#toggler').removeClass('fa-bars');
        $('#toggler').addClass('fa-times');
    }
});

// Closing the navbar when a navigation link is clicked
$(window).on('click', function(event) {
    if ($(event.target).hasClass('navlink')) {
        $('.navlinks').removeClass('show-menu');
        $('#toggler').removeClass('fa-times');
        $('#toggler').addClass('fa-bars');
    }
});
