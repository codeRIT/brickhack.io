var ready;

var questionOpen = false;
var mobileNavOpen = false;
var mobileNavHover = false;

ready = function() {

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

    $('.faq-action-expand').on('click', function(event) {
        var container = $('.faq-container-outer')[0];
        if (container.classList.contains('faq-ex-open')) {
            container.classList.remove('faq-ex-open');
        } else {
            container.classList.add('faq-ex-open');
        }
    });

    $('.faq-action-close').on('click', function(event) {
        $('.faq .question')[0].click();
    });

    $('nav.desktop').on('mouseover', function(event) {
        var openClass = 'nav-ex-open';
        var nav = $('nav.desktop')[0];
        if (!nav.classList.contains(openClass)) {
            nav.classList.add(openClass);
            mobileNavHover = true;
        }
    });

    $('nav.desktop').on('mouseout', function(event) {
        var openClass = 'nav-ex-open';
        var nav = $('nav.desktop')[0];
        if (nav.classList.contains(openClass)) {
            nav.classList.remove(openClass);
            mobileNavHover = false;
        }
    });

    $('nav.desktop .logo').on('click', function(event) {
      var openClass = 'nav-ex-open';
      var nav = $('nav.desktop')[0];
      if (nav.classList.contains(openClass)) {
          if (mobileNavHover) {
              mobileNavHover = false;
              mobileNavOpen = true;
              return;
          }
          if (mobileNavOpen) {
              window.location = '#';
          }
          nav.classList.remove(openClass);
          mobileNavOpen = false;
      } else {
          nav.classList.add(openClass);
          mobileNavOpen = true;
      }
    });

    $('.faq .question').on('click', function(event) {
        var me=event.target;
        var item = me.parentElement;
        var questionColumn = item.parentElement;
        var questions = $('.faq-container').children('.column');

        if (questionOpen) {
            $('.faq-container')[0].classList.remove('faq-ex-select');
            $('.faq-ex-qopen')[0].classList.remove('faq-ex-qopen');
            questions.css('display', 'inline-block');
        } else {
            $('.faq-container')[0].classList.add('faq-ex-select');
            questionColumn.classList.add('faq-ex-qopen');
            questions.not(questionColumn).each(function(index, value) {
                $(value).css('display', 'none');
            });
        }

        questionOpen = !questionOpen;
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
