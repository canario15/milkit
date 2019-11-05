// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery.min.js
//= require popper.min.js
//= require bootstrap.min.js
//= require jquery.matchHeight.min.js
//= require main.js
//= require bootstrap-datepicker.min.js
//= require bootstrap-datepicker.es.min.js
//= require datatables.min.js
//= require dataTables.bootstrap.min.js
//= require datatables-init.js


jQuery(document).ready(function($) {
  "use strict";

  $('#save_cow').click(function (e) {
    e.preventDefault();
    $('#cow_caravan').parent().parent().removeClass('error-field');
    $('#cow_status').parent().parent().removeClass('error-field');
    $('#cow_cow_type').parent().parent().removeClass('error-field');
    $('#new_cow_modal .span-err').remove();
    $.ajax({
      type    : 'POST',
      url     : $('#cow_form').attr('action'),
      data    : $('#cow_form').serialize(),
      dataType  : 'json'
    }).done(function(data) {
      if ( data.status == 'OK') {
        $('#new_cow_modal').modal('hide');
        $("#cow_form")[0].reset();
        debugger
        window.location.replace("/tambos/"+ data.tambo_id + "/cows/" + data.cow_id );
      }else{
        if (data.errors.caravan) {
          $('#cow_caravan').parent().parent().addClass('error-field');
          $('#cow_caravan').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i> "+ data.errors.caravan + "</span>");
        }
        if (data.errors.status) {
          $('#cow_status').parent().parent().addClass('error-field');
          $('#cow_status').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i> "+ data.errors.status + "</span>");
        }
        if (data.errors.cow_type) {
          $('#cow_cow_type').parent().parent().addClass('error-field');
          $('#cow_cow_type').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i> "+ data.errors.cow_type + "</span>");
        }
      }
    })
    .fail(function(data) {
    });
  });

  $('#save_event').click(function (e) {
    e.preventDefault();
    $('#event_date_event').parent().parent().removeClass('error-field');
    $('#event_action').parent().parent().removeClass('error-field');
    $('#new_event_modal .span-err').remove();
    $.ajax({
      type    : 'POST',
      url     : $('#event_form').attr('action'),
      data    : $('#event_form').serialize(),
      dataType  : 'json'
    }).done(function(data) {
      if ( data.status == 'OK') {
        $('#new_event_modal').modal('hide');
        $("#event_form")[0].reset();
        document.location.reload();
      }else{
        if (data.errors.date_event) {
          $('#event_date_event').parent().parent().addClass('error-field');
          $('#event_date_event').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i> "+ data.errors.date_event + "</span>");
        }
        if (data.errors.action) {
          $('#event_action').parent().parent().addClass('error-field');
          $('#event_action').parent().append("<span class='span-err'> <i class='fa fa-exclamation-triangle'></i> "+ data.errors.action + "</span>");
        }
      }
    })
    .fail(function(data) {
    });
  });

  $('#bootstrap-data-table').DataTable();

});
