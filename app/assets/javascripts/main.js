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

  var $sidebar = $('.sidebar');

  $('#sidebar-toggle').on('click', function () {
    if ($sidebar.hasClass('open'))
      $sidebar.removeClass('open');
    else
      $sidebar.addClass('open');
  });

  $.fn.validate = function() {
    var previous_invalid_inputs = [];

    var validateInput = function() {
      var success = true, types = $(this).data('validate').split(/[ ,]+/), value = $(this).val();
      for (i = types.length-1; i >= 0; i--) {
        switch (types[i]) {
          case 'presence':
            if (!value || $.trim(value).length < 1) {
              notify(this, "Missing Information");
              success = false;
            }
          break;
          case 'email':
            if (value) {
              var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
              if (!re.test(value)) {
                notify(this, "Invalid Email");
                success = false;
              }
            }
          break;
          case 'file-max-size':
            if (this.files && this.files[0] && this.files[0].size > parseInt($(this).data('validate-file-max-size'))) {
              notify(this, "File Too Large");
              success = false;
            }
          break;
          case 'file-content-type':
            if (this.files && this.files[0] && this.files[0].type != $(this).data('validate-file-content-type')) {
              notify(this, "Invalid File Type");
              success = false;
            }
          break;
        }
      }
      if (success) {
        $(this).parent().removeClass('field_with_errors').find('.error').fadeOut(200, function() {
          $(this).remove();
        });
      }
      return success;
    };

    var validateAll = function() {
      var success = true, invalid_inputs = [], first_input;
      $(this).find('[data-validate]').each(function(i) {
        if (!validateInput.call(this)) {
          success = false;
          invalid_inputs.push(i);
          if (!first_input || $(this).is(':focus')) {
            first_input = this;
          }
        }
      });
      if (invalid_inputs.length > 0 && $(invalid_inputs).not(previous_invalid_inputs).length == 0 && $(previous_invalid_inputs).not(invalid_inputs).length == 0) {
        $(this).find('[data-validate]').each(function() {
          $(this).parent().find('.error').fadeOut(50).fadeIn(100);
        });
      }
      if (first_input) {
        $(first_input).focus();
      }
      previous_invalid_inputs = invalid_inputs;
      return success;
    };

    var notify = function(input, message) {
      var $element = $(input).parent().find('.error');
      if ($element.length < 1)  {
        $element = $('<span class="error"></span>').hide().insertAfter(input);
      }
      $element.text(message);
      $element.fadeIn(100);
      $element.parent().addClass('field_with_errors');
    };

    $(this).on('submit', validateAll);
    $(this).find('[data-validate]').each(function() {
      $(this).on('blur', validateInput);
    });
  };

  $('[data-validate=form]').validate();

});
