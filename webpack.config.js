const path = require('path'),

      HtmlWebpackPlugin = require('html-webpack-plugin'),
      ExtractTextPlugin = require('extract-text-webpack-plugin'),

      extractCSS = new ExtractTextPlugin('main.css');


module.exports = require('webpack-validator')({
  entry: path.join(__dirname, './src/main.js'),

  output: {
    path: path.join(__dirname, 'dist'),
    filename: '[hash].js',
  },

  resolve: {
    extensions: ['', '.js'],
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        loader: 'babel',
        query: {
          presets: [
            "es2017",
          ],

          plugins: [
            "transform-decorators-legacy",
          ],
        }
      },

      {
        test: /\.scss$/,
        loader: extractCSS.extract([
          'css',
          'sass',
        ]),
      },

      {
        test: /.html$/,
        loader: 'html',
      },
    ],
  },

  plugins: [
    extractCSS,

    new HtmlWebpackPlugin({
      hash: false,
      inject: 'body',
      template: './src/index.ejs',
      title: 'monokro.me',
      xhtml: true,
    }),
  ],
});
