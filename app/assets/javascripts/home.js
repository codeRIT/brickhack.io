var ready;
ready = function() {
    function recalc(){
        // pages will be scaled to 100% height
        $('.page').outerHeight($(window).height())

        // setting the height of background image
        wh = $(window).height();
        ww = $(window).width();
        if (ww >= 700) {
            $('.bg-image').outerHeight(wh * 0.4)
            $('.orange-fill').height(wh * 0.4)
        }else{
            $('.bg-image').outerHeight(wh * 0.2)
            $('.orange-fill').height(wh * 0.2)
        }
        //center elements vertically
        $('.center-vertical').each(function(){
           $(this).css('padding-top',($(this).parent().height()/2 - $(this).height()/2))
        });
    }
    $(window).resize(function(){
        recalc();
    });
    recalc();

    // smooth scrolling
    $('a[href*=#]:not([href=#])').click(function() {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
            if (target.length) {
                //change color
                $('nav>a').removeClass('active');
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