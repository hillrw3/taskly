//= require jquery
//= require jquery_ujs
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
          var button = $(this).siblings('dt').find('button');
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

});

