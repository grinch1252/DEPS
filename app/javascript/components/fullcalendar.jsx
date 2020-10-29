import React, { Component } from 'react'
import FullCalendar from "@fullcalendar/react"
import dayGridPlugin from "@fullcalendar/daygrid"
import timeGridPlugin from "@fullcalendar/timegrid"
import interactionPlugin from "@fullcalendar/interaction"

// function EventItem(props) {
//   return (
//     <li key={props.event.id}>
//       <label>
//         <span className="title">
//           {props.event.title}
//         </span>
//         <span className="start">
//           {props.event.start}
//         </span>
//       </label>
//     </li>
//   );
// }

// function EventsList(props) {
//   const events = props.events.map(event => {
//     return (
//       <EventItem
//         key={event.id}
//         event={event}
//       />
//     );
//   });
//   return (
//     <ul>
//       {props.events.length ? events : <li>Event is nothing!</li>}
//     </ul>
//   );
// };

export default class Fullcalendar extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      events: props.events,
      loading: false
    }

    this.handleDateClick = this.handleDateClick.bind(this);
  }

  handleDateClick = (info) => {
    this.setState({
      loading:true
    })
    const dateinfo = confirm(`Do you want add new event on ${info.dateStr}?`);
    if (dateinfo) {
      let title = prompt("Enter Title");
      if (title == "" || title == null) {
        alert("Event needs title")
      } else {
        let body = prompt("Enter Detail");
        let startTime = info.dateStr;

        $.ajax({
          url: `/events`,
          dataType: 'json',
          contentType: 'application/json',
          type: 'POST',
          data: JSON.stringify({
            title: title,
            start: startTime,
            body: body
          }),
          beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
          },
          cache: false
        }).then((response) => {
          this.setState({
            loading: false,
            title: response,
            start: response,
            body: response
          })
        })
      }
    }
  }

  render() {
    return (
      <FullCalendar
        defaultView="dayGridMonth"
        plugins={[ dayGridPlugin, interactionPlugin ]}
        events= '/events.json'
        dateClick={this.handleDateClick}
      />
    )
  }
}
