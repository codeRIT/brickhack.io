$(document).ready(function () {

  $('.nav-link, .scroll-to').on('click', function (e) {
    e.preventDefault();
    var id = $(e.currentTarget).attr('href')
    var target = $(id);
    $('html,body').animate({
      scrollTop: (target.offset().top)
    }, 1000);
  });

});