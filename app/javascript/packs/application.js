// This file is automatically compiled by Webpack, along with any other files
require("jquery")
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("turbolinks").start()
require("bootstrap")
require("moment")
require("channels")
require("chartkick")
require("chart.js")
require("fullcalendar")

import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin],
    selectable: true,
    events: '/events.json',
    headerToolbar: {
      left: 'prev,next',
      center: 'title',
      right: 'today'
    }
  });

  calendar.render();
  });


