// This file is automatically compiled by Webpack, along with any other files
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("bootstrap")
require("channels")
require("chartkick")
require("chart.js")

import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin ]
  });

  calendar.render();
});