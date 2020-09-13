const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    '$': 'jquery',
    'window.$': 'jquery',
    jQuery: 'jquery',
    'jQuery': 'jquery',
    'window.jQuery': 'jquery',
    jquery: 'jquery',
    'jquery': 'jquery',
    'window.jquery': 'jquery',
    Rails: ['@rails/ujs']
  })
)


module.exports = environment
