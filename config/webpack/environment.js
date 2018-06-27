const { environment } = require('@rails/webpacker')

environment.loaders.append('slim', {
  test: /\.slim$/,
  use: [
    { loader: 'ngtemplate-loader' },
    { loader: 'html-loader' },
    { loader: 'slim-lang-loader' }
  ]
})

module.exports = environment
