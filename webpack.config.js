const path = require('path'),

      HtmlWebpackPlugin = require('html-webpack-plugin'),
      ExtractTextPlugin = require('extract-text-webpack-plugin'),

      extractCSS = new ExtractTextPlugin('main.css'),

      html = new HtmlWebpackPlugin({
        hash: false,
        inject: true,
        template: './src/index.ejs',
        title: 'monokro.me',
        xhtml: true,
      });


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
        exclude: /node_modules/,

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
        exclude: /node_modules/,

        loader: extractCSS.extract([
          'css',
          'autoprefixer',
          'sass',
        ]),
      },

      {
        test: /.html$/,
        exclude: /node_modules/,

        loaders: [
          'html',
        ],
      },
    ],
  },

  plugins: [
    extractCSS,
    html,
  ],
});
