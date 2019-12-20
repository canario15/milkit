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
//= require fullcalendar/locale-all


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
    events: '/notifications.json',
    locale: 'es',
    eventRender: function(event, element){
      element.find('.fc-title').html(event.tambo + "<br/>" + event.caravan + "<br/>" + event.description ); 
    }
  });
 
});
