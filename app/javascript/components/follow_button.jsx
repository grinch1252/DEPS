import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class FollowButton extends Component {
  constructor(props) {
    super(props)

    this.state = {
      loading: false,
      relationship: props.relationship,
      following: props.following,
      followers: props.followers
    }
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
        <div>{ this.state.following }</div>
        <div>{ this.state.followers }</div>
        <div>
          <button className={ className } onClick={ this.handleClickFollowButton } disabled={ this.state.loading }>
            { this.state.relationship !== null ? 'Unfollow' : 'Follow' }
          </button>
        </div>
      </div>
    )
  }
}

FollowButton.defaultProps = {
  relationship: null
}

FollowButton.propTypes = {
  relationship: PropTypes.object,
  user: PropTypes.object.isRequired
}