const path = require('path'),

      HtmlWebpackPlugin = require('html-webpack-plugin'),
      ExtractTextPlugin = require('extract-text-webpack-plugin');


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
        test: path.join(__dirname, 'src', 'main.css'),
        loader: ExtractTextPlugin.extract("style-loader", "css-loader"),
      },

      {
        test: /.html$/,
        loader: 'html',
      },
    ],
  },

  plugins: [
    new ExtractTextPlugin('[hash].css'),

    new HtmlWebpackPlugin({
      hash: false,
      inject: 'body',
      template: './src/index.ejs',
      title: 'monokro.me',
      xhtml: true,
    }),
  ],
});
