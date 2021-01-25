import './sass/gallery.scss'
import '@fortawesome/fontawesome-free/css/all.css'
import LazyLoad from "vanilla-lazyload";
import $ from 'jquery'

var lazyLoad = new LazyLoad();

var AWS = require('aws-sdk');
import {identityPoolId} from './keys.js';

// Getting images onto the page
var albumBucketName = 'brickhack-gallery';
// Credentials

// TODO: Load from env variables so GH pages can access
AWS.config.region = 'us-east-1'; // Region
AWS.config.credentials = new AWS.CognitoIdentityCredentials({
    IdentityPoolId: identityPoolId
});

// Service Object
var s3 = new AWS.S3({
    apiVersion: '2006-03-01',
    params: {Bucket: albumBucketName}
});

viewAlbum('bh6');
viewAlbum('bh5');

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
            // Seeing if there is actually an image (s3 adds a blank to count the number of images at the beginning)
            if (photo.Size == 0) {
                return;
            }
            return getHtml([
                '<div class="lazy image" data-bg="' + photoUrl + '"></div>',
            ]);
        });

        document.getElementById(albumName).innerHTML = getHtml(photos);
        lazyLoad.update();
    });
}

// Opening modal
$(document).on('click', function(event) {
    if ($(event.target).hasClass('image')) {
        $('#modal').show();
        var top = 'calc(5% + ' + (window.scrollY) + 'px)';
        $('#modal-img').attr('src', $(event.target).attr('data-bg'));
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
