const path = require('path'),

      ExtractTextPlugin = require('extract-text-webpack-plugin');


module.exports = require('webpack-validator')({
  entry: path.join(__dirname, './src/index.pug'),

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
        test: /\.css$/,
        loader: ExtractTextPlugin.extract("style-loader", "css-loader"),
      },

      {
        test: /\.pug/,
        loaders: [
          'html?attrs=img:src&link:href',
          'pug-html-loader',
        ],
      },
    ],
  },

  plugins: [
    new ExtractTextPlugin('[hash].css'),
  ],
});
