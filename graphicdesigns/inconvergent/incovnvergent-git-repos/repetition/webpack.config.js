const path = require('path');
const entry = ['./index.js'];

if (process.argv[3] !== '-p') {
  entry.push('webpack/hot/dev-server');
}

module.exports = {
  entry,
  output: {
    path: path.resolve(__dirname, 'dist'),
    publicPath: '/build/',
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: /(node_modules|bower_components)/,
        loader: 'babel',
        query: {
          presets: ['es2015']
        }
      }
    ]
  }
};
