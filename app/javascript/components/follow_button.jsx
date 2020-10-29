import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class FollowButton extends Component {
  constructor(props) {
    super(props)

    this.state = {
      loading: false,
      relationship: props.relationship
    }

    this.handleClickFollowButton = this.handleClickFollowButton.bind(this);
    this.follow = this.follow.bind(this);
    this.unfollow = this.unfollow.bind(this);

  }

  follow = () => {
    this.setState({
      loading: true
    })

    $.ajax({
      url: `/relationships`,
      dataType: 'json',
      contentType: 'application/json',
      type: 'POST',
      data: JSON.stringify({
        followed_id: this.props.user.id
      }),
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      cache: false
    }).then((response) => {
      this.setState({
        loading: false,
        relationship: response
      })
    })
  }
  
  unfollow = () => {
    this.setState({
      loading: true
    })

    $.ajax({
      url: `/relationships/${this.state.relationship.id}`,
      dataType: 'json',
      contentType: 'application/json',
      type: 'DELETE',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      cache: false
    }).then((response) => {
      this.setState({
        loading: false,
        relationship: null
      })
    })
  }

  handleClickFollowButton = () => {
    if (this.state.relationship !== null) {
      this.unfollow()
    }
    else {
      this.follow()
    }
  }

  render() {
    let className = ''
    if (this.state.relationship !== null) {
      className += 'btn btn-secondary btn-block'
    }
    else {
      className += 'btn btn-info btn-block'
    }

    return (
      <div id="root">
        <div>
          <button className={ className } onClick={ this.handleClickFollowButton }>
            { this.state.relationship !== null ? 'Unfollow' : 'Follow' }
          </button>
        </div>
      </div>
    )
  }
}

