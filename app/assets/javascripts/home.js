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


    $('.carousel').carousel({
            dist:0,
            shift:0,
            padding:20,

      });

    var $last = $("#previous"); //previous button
    var $next = $("#next"); //next button
    var $car = $("#slider"); //the whole slider
    var $count = 1; //the current image
    var $total = 3; //the amount of images

    $("#images img").hide(); //hide all images
    $("#" + $count).show(); //except the index image

    $last.click(function() {
      //when the 'last' button is clicked
      $("#" + $count).fadeOut(300, function() {
        //fade out the currently shown image

        //if the count is > 1
        if ($count > 1) {
          //decrement count
          $count--;
        } else {
          //else, loop back around so that the last image is shown
          $count = $total;
        }

        //find the next image
        $item = $("#" + $count);

        //fade in the next image
        $item.fadeIn(300);
      });
    })

    $next.click(function() {
      //when the 'next' button is clicked
      $("#" + $count).fadeOut(300, function() {
        //fade out the currently shown image

        //if the count is less than the total amount of image
        if ($count < $total) {
          //increment the count
          $count++;
        } else {
          //else, loop back around so that the first image is shown
          $count = 1;
        }

        //find the next image
        $item = $("#" + $count);

        //fade in the next image
        $item.fadeIn(300);
      });
    })


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
                    scrollTop: target.offset().top - 170
                }, 500);
                return false;
            }
        }
    });

    $('.schedule__trigger').on('mouseover', function() {
        $(this).parents('.schedule__row').addClass('schedule__row--hover');
    });
    $('.schedule__trigger').on('mouseout', function() {
        $(this).parents('.schedule__row').removeClass('schedule__row--hover');
    });
    $('.schedule__trigger').on('click', function() {
        $('.schedule__row--selected').removeClass('schedule__row--selected');
        $(this).parents('.schedule__row').addClass('schedule__row--selected');
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);
