import React, {Component} from 'react'

class AddUserPage extends Component {
  constructor(props) {
    super(props)
    this.state = { error: null }
  }

  onSubmit = () => {
    return null
  }

  render() {
    return (
      <section className="add-user-section">
        <div className="container d-flex justify-content-center">
          <div className="col-10">
            <h1>Add GitHub Account</h1>
            <form name="form" onSubmit={this.onSubmit} className="form-group">
              <div className="form-group">
                {
                  this.state.error && (
                    <div class="alert alert-error">{this.state.error}></div>
                  )
                }
                <label for="name">GitHub Account:</label>
                <input type="text" id="name" ng-model="user.name"></input>
              </div>
              <div className="form-group">
                <button className="btn btn-large btn-primary" type="submit">Add Account</button>
              </div>
            </form>
          </div>
        </div>
      </section>
    )
  }
}

export default AddUserPage