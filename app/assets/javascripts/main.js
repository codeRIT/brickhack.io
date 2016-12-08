$(document).ready(function () {

  var $sidebar = $('.sidebar');

  if ($('.carousel').length > 0) {
    $('.maps.carousel').owlCarousel({
      items: 3,
      singleItem: true
    });
    $('.support.carousel').owlCarousel({
      singleItem: true
    });
    $('.mentor-list.carousel').owlCarousel({
      singleItem: true
    });
  }

  if ( $sidebar.hasClass('home') ) {
    $('.nav-link, .scroll-to').on('click', function (e) {
      e.preventDefault();
      $('.active').removeClass('active');
      $(e.currentTarget).addClass('active');
      var id = $(e.currentTarget).attr('href');
      id = id.substring(1);
      var $target = $(id);
      $target.addClass('active');
      $('html,body').animate({
        scrollTop: ($target.offset().top)
      }, 1000);
    });
  }

  $('#sidebar-toggle').on('click', toggleSidebar);

  function toggleSidebar (e) {
    if ($sidebar.hasClass('open')) {
      $('#main').off('click', toggleSidebar);
      $sidebar.removeClass('open');
    }
    else {
      $('#main').on('click', toggleSidebar);
      $sidebar.addClass('open');
    }
  }

  $.fn.toggleDetails = function() {
    var toggle = function() {
      $('.details').slideUp();
      $(this).parent().find('.details:hidden').slideDown();
    };

    $(this).each(function() {
      $(this).on('click', toggle);
    });
  };

  $('.toggle-details').toggleDetails();

  $.fn.toggleBlock = function() {
    var toggle = function() {
      var $this = $(this);
      $('.info').slideUp();
      $('#' + $this.data('target') + ':hidden').slideDown();
    };
    $(this).each(function() {
      $(this).on('click', toggle);
    });
  };
  $('.block .name').toggleBlock();

  $('[name="questionnaire[travel_not_from_school]"]').on('change', function() {
    var $location = $('[name="questionnaire[travel_location]"]');
    if (this.value === "true") {
      $location.parent().show();
      $location.prop('disabled', false);
    }
    else {
      $location.parent().hide();
      $location.prop('disabled', true);
    }
  });

  $('[name="questionnaire[acc_status]"]').on('change', function() {
    var $content = $('.hide-if-not-attending');
    if ($(this).val() == 'rsvp_denied') {
      $content.hide();
    }
    else {
      $content.show();
    }
  });

  $.fn.validate = function(option) {
    var previous_invalid_inputs = [];

    var validateInput = function() {
      var success = true, types = $(this).data('validate').split(/[ ,]+/), value = $(this).val();
      if ($(this).is(':checkbox') && !$(this).is(':checked')) {
        value = "";
      }
      if ($(this).is(':disabled')) {
        return true;
      }
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

    if (option == 'now') {
      return validateAll.call(this);
    }
    else {
      $(this).on('submit', function() {
        $(this).find('[type=submit]').prop('disabled', true);
        if (!validateAll.call(this)) {
          $(this).find('[type=submit]').prop('disabled', false);
          return false;
        }
        return true;
      });
      $(this).find('[data-validate]').each(function() {
        $(this).on('blur', validateInput);
      });
    }
  };

  $('[data-validate=form]').validate();

  $.fn.wizard = function() {
    var form = this;

    var goToStage = function($newStage) {
      $(form).find('.wizard-current').removeClass('wizard-current');
      $newStage.addClass('wizard-current');
      $("html, body").animate({ scrollTop: 0 }, "slow");
      if ($newStage.find('.field_with_errors').length > 0) {
        $newStage.find(".field_with_errors").first().find(":input").focus();
      } else {
        $newStage.find(":input").first().focus();
      }
    }

    var nextStage = function() {
      if (!$(form).find('.wizard-current').validate('now')) {
        return false;
      }
      goToStage($(form).find('.wizard-current').next());
    };

    var previousStage = function() {
      goToStage($(form).find('.wizard-current').prev());
    };

    if ($(form).find('.field_with_errors').length > 0) {
      goToStage($(form).find('.field_with_errors').first().parents('.wizard-stage'));
    }
    $(this).find('[data-wizard=next]').each(function() {
      $(this).on('click', nextStage);
    });
    $(this).find('[data-wizard=previous]').each(function() {
      $(this).on('click', previousStage);
    });
    if ($(this).is('.wizard-skip-valid')) {
      nextStage.call(this);
    }
  };

  $('.wizard').wizard();

});
