$(document).ready(function () {

  $('.nav-link, .scroll-to').on('click', function (e) {
    e.preventDefault();
    $('.active').removeClass('active');
    $(e.currentTarget).addClass('active');
    var id = $(e.currentTarget).attr('href');
    var $target = $(id);
    $target.addClass('active');
    $('html,body').animate({
      scrollTop: ($target.offset().top)
    }, 1000);
  });

});