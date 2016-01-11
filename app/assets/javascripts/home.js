var ready;
ready = function() {
    function recalc(){
        // pages will be scaled to 100% height
        $('.page').height($(window).height())

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
                $('html,body').animate({
                    scrollTop: target.offset().top
                }, 500);
                return false;
            }
        }
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);