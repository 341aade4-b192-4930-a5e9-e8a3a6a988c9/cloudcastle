import React, {Component} from 'react'

class RatingPage extends Component {
  render() {
    return (
      <section className="rating-section">
        <div className="container d-flex justify-content-center">
          <div className="col-12">
            <h1>Rating Tables</h1>
            Top 10 developers:
            <div className="row">
              <div className="col-6">
                <h5>followers + all watchers.</h5>
                <table className="table">
                  <thead>
                    <tr>
                      <th>№</th>
                      <th>User Name</th>
                      <th>Rank</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td></td>
                      <td></td>
                      <td></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div className="col-6">
                <h5>forks + repositories.</h5>
                <div>
                  <table className="table">
                    <thead>
                      <tr>
                        <th>№</th>
                        <th>User Name</th>
                        <th>Rank</th>
                      </tr>
                    </thead>
                    <tbody>
                    <tr>
                      <td></td>
                      <td></td>
                      <td></td>
                    </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    )
  }
}

export default RatingPage
