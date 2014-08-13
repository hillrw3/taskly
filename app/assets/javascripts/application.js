//= require jquery
//= require jquery_ujs
//= require pickadate/picker
//= require pickadate/picker.date
//= require_tree .

$(document).ready(function () {

  var tasks = $('.tasks')

  var showPanel = function (id, e) {
    console.log(e)
    if (tasks.is(':visible')) {
      $('.tasks').slideUp('slow')
    } else {
      $('.tasks').each(function () {
        if ($(this).attr('id') == id) {
          $(this).slideDown('slow');
        } else {
          $(this).slideUp('slow');
        }
      });
    }
  };

  window.showPanel = showPanel;

//  var button = $('.panel button')
//
//  button.on('click',function(){
//    if(button.text == 'Open') {
//      $(this).text = 'Close';
//      $(this).siblings.find('.tasks').slideDown('slow')
//    } else {
//      $(this).text = 'Open';
//    }
//  });

  setTimeout("$('.flash').hide();", 5000);

  $('.flash button').on('click', function () {
    $('.flash').hide();
  });


  $('.datepicker').pickadate({
    formatSubmit: 'yyyy-mm-dd',
    min: true
  });


  var inputs = $('.create-form input[type=text]');
  inputs.addClass('red-border');
  inputs.each(function(){
    $(this).keyup(function() {
      $(this).removeClass('red-border');
    });
  });


  $('input[type=submit]').prop('disabled', 'disabled');
  $('input:not(:hidden)').keyup(function () {
    if ($(this).val().length != 0) {
      $('input[type=submit]').prop('disabled', false);
    } else {
      $('input[type=submit]').prop('disabled', 'disabled');
    }
  });


});

