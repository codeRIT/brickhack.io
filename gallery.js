import './sass/gallery.scss'
import '@fortawesome/fontawesome-free/css/all.css'
import LazyLoad from "vanilla-lazyload";
import $ from 'jquery'

var lazyLoad = new LazyLoad();

var AWS = require('aws-sdk');

// Getting images onto the page
var albumBucketName = 'brickhack-gallery';

// Credentials
AWS.config.region = 'us-east-1'; // Region
AWS.config.credentials = new AWS.CognitoIdentityCredentials({
    IdentityPoolId: process.env.IDENTITY_POOL_ID
});

// Service Object
var s3 = new AWS.S3({
    apiVersion: '2006-03-01',
    params: {Bucket: albumBucketName}
});

var brickhacks = ['bh6', 'bh5', 'bh4', 'bh3', 'bh2', 'bh'];
for (let name of brickhacks) {
    viewAlbum(name);
}

// Used to create HTML for our images
function getHtml(template) {
    return template.join('\n');
}
function viewAlbum(albumName) {
    var albumPhotosKey = encodeURIComponent(albumName) + '/thumb/';
    s3.listObjects({Prefix: albumPhotosKey}, function(err, data) {
        if (err) {
            return alert('Oopsie! There was an error viewing ' + albumName + ': ' + err.message);
        }

        var href = this.request.httpRequest.endpoint.href;
        var bucketUrl = href + albumBucketName + '/';

        var photos = data.Contents.map(function(photo) {
            var photoKey = photo.Key;
            var photoUrl = bucketUrl + photoKey;

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
        var fullUrl = $(event.target).attr('data-bg').replaceAll('/thumb/', '/full/');
        $('#modal-img').attr('src', fullUrl);
        $('#modal-container').css('display', 'flex');
        $('html').css('overflow', 'hidden');
    }
});

// Closing modal with x
$('#close-modal').on('click', function() {
    $('#modal-container').hide();
    $('html').css('overflow', '');
});

$('#modal').on('click', function(event) {
    event.stopPropagation();
});

// Closing modal with background
$('#modal-container').on('click', function(event) {
    $('#modal-container').hide();
    $('html').css('overflow', '');
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
