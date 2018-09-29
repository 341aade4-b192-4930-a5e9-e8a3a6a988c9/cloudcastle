import React, {Component} from 'react'

class HomePage extends Component {
  render() {
    return (
      <section className="home-section">
        <div className="container d-flex justify-content-center">
          <div className="col-10">
            <h1>GitHub Developer Rating</h1>
            <h2>The site provides an opportunity to collect statistic and build rating tables for GitHub developers.</h2>
            <a className="btn btn-large btn-primary" href="add_user">Add GitHub Account</a>
          </div>
        </div>
      </section>
    )
  }
}

export default HomePage