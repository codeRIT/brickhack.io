var ready;
ready = function() {

    // when mobile hamburger menu is clicked
    $('#hamburger-menu').click(function(){
        // TODO: this isn't optimized on mobile.  use css instead of jquery in the future
       $('#mobile-nav').slideToggle('fast');
    });

    // close hamburger menu when item is clicked
    $('a.mobile').click(function(){
        $('#mobile-nav').delay(400).slideUp('fast');
    });

    // make sure images have the correct vertical height when loaded
    $('img').load(function(){
       recalc();
    });

    // bulk add animations
    $('.faq h2, .faq h3').addClass('wow').addClass('fade-in')

    // fancy animations
    $('.wow.rotate-in')
        .transition(
            {
            rotate: '25deg',
            scale: 0.5
            }, 0
        );

    $('.wow.fade-in')
        .transition(
            {
                opacity: 0.2,
                scale: 0.9
            }, 0
        );

    $('.wow').each(function(){

        $(this).waypoint(function(){
            $(this).transition(
                {
                    rotate: '0deg',
                    scale: 1,
                    opacity: 1
                }, 500
            )
        },{offset: '75%'});
    });







    function recalc(){
        // pages will be scaled to 100% height
        $('.page').outerHeight($(window).height())
    }
    $(window).resize(function(){
        recalc();
    });
    recalc();

    // smooth scrolling
    $('a[href*="#"]:not([href="#"])').click(function() {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
            if (target.length) {
                //change color
                $('nav a').removeClass('active');
                $(this).addClass('active');
                //scroll
                $('html,body').stop().animate({
                    scrollTop: target.offset().top - 72
                }, 500);
                return false;
            }
        }
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);
