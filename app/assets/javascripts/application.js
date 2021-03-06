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
//= require notify.js
//= require moment 
//= require fullcalendar
//= require fullcalendar/locale-all.js
//= require jquery.minicolors

jQuery(document).ready(function($) {
  "use strict";

  if ($('#have_alert').text() != 0 ){
    var type    = $('#have_alert').data('type');
    var message = $('#have_alert').text();
    $.notify(
      message,
      { position:"top center",
        className: type
      }
    );
    $('#have_alert').remove();
  };

  $('#bootstrap-data-table-2').DataTable({
    "ordering": false,
    "columnDefs": [
      { "targets": [1,2,3,4,5], "searchable": false }
    ],
    "language": {
      "processing":     "Procesando...",
      "lengthMenu":     "Mostrar _MENU_ registros",
      "zeroRecords":    "No se encontraron resultados",
      "emptyTable":     "Ningún dato disponible en esta tabla =(",
      "info":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
      "infoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
      "infoFiltered":   "(filtrado de un total de _MAX_ registros)",
      "infoPostFix":    "",
      "search":         "Buscar:",
      "url":            "",
      "infoThousands":  ",",
      "loadingRecords": "Cargando...",
      "paginate": {
          "first":    "Primero",
          "last":     "Último",
          "next":     "Siguiente",
          "previous": "Anterior"
      }
    }
  });

  $('#calendar').fullCalendar({
    locale: 'es',
    weekNumbers: true,
    dayNamesShort: ['Lun','Mar','Mie','Jue','Vie','Sáb','Dom'],
    monthNames: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"],
    events: '/notifications.json',
    eventLimit: 2,
    eventRender: function(event, element){
      element.find('.fc-title').html(event.tambo + "<br/>" + event.caravan + "<br/>" + event.description );
      element.attr("title", event.title);
    },
  });

  $('.fc-event').tooltip({
    container: 'body'
  });

  $('#tambo_notification_color').minicolors({
    theme: 'bootstrap'
  });
 
  $('#event_action').on('change' , function () {
    $('.notify-mess').html("");
    $('#event_notify_description').val("");
    $('#event_notify_date').val("");
    var event_action = $(this).val();
    switch (event_action) {
      case 'served':
        served_actions();
        break;
      case 'pregnant':
        pregnant_actions();
        break;
      case 'dry':
        break;
      case 'gave_birth':
        break;
      case 'empty':
        break;
      default:
        
    }
  });

  Date.prototype.addDays = function(days) {
    var date = new Date(this.valueOf());
    date.setDate(date.getDate() + days);
    return date;
  } 
});

function pregnant_actions() {
  var service_date_value = $('#service_date').val();
  if (service_date_value != "") {
    var service_date = new Date(service_date_value);
    var service_date_string = service_date.getUTCDate() +"/"+ (service_date.getUTCMonth()+1) +"/"+ service_date.getUTCFullYear(); 
    var notify_date = service_date.addDays(190);
    var notify_date_string = notify_date.getUTCDate() +"/"+ (notify_date.getUTCMonth()+1) +"/"+ notify_date.getUTCFullYear();
    $('#event_notify_date').val(notify_date_string);
    $('#event_date_event').val(service_date_string);
    
  }else{
    var notif = "<span class='help-inline'>No existe fecha de 'Servida' para setear notificación automática.</span>"
    $('.notify-mess').append(notif);
  }
  $('#event_notify_description').val("Revisar para secar");
}
function served_actions() {
  var res = $('#event_date_event').val().split("/");
  if (res != "") {
    var service_date_value = res[2]+"/"+res[1]+"/"+res[0];
    var service_date = new Date(service_date_value);
    var notify_date = service_date.addDays(45);
    var notify_date_string = notify_date.getUTCDate() +"/"+ (notify_date.getUTCMonth()+1) +"/"+ notify_date.getUTCFullYear();
    $('#event_notify_date').val(notify_date_string);
  }else{
    var notif = "<span class='help-inline'>No existe fecha del evento para setear notificación automática.</span>"
    $('.notify-mess').append(notif);
  }
  $('#event_notify_description').val("Revisar para ecografía");
}
