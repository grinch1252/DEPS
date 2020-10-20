///= require rails-ujs
//= require jquery3
//= require bootstrap
//= require turbolinks
//= require chartkick
//= require Chart.bundle
//= require moment
//= require fullcalendar

$(function () {
  function eventCalendar() {
      return $('#calendar').fullCalendar({});
  };
  function clearCalendar() {
      $('#calendar').html('');
  };
});

$(document).on('turbolinks:load', function () {
  eventCalendar();
});
$(document).on('turbolinks:before-cache', clearCalendar);