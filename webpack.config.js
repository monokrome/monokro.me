const path = require('path'),

      HtmlWebpackPlugin = require('html-webpack-plugin'),
      ExtractTextPlugin = require('extract-text-webpack-plugin'),

      Joi = require('webpack-validator').Joi,

      extractCSS = new ExtractTextPlugin('main.css'),

      html = new HtmlWebpackPlugin({
        hash: false,
        inject: true,
        template: './client/index.ejs',
        title: 'monokro.me',
        xhtml: true,
      });


module.exports = require('webpack-validator')({
  entry: path.join(__dirname, './client/main.js'),

  output: {
    path: path.join(__dirname, 'dist'),
    filename: '[hash].js',
  },

  resolve: {
    root: path.join(__dirname, 'client'),
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

  devServer: {
    contentBase: path.join(__dirname, 'dist'),
  },

  sassLoader: {
    includePaths: [
      path.join(__dirname, 'client'),
    ]
  },

  devtool: 'source-map',
}, {
  schemaExtension: Joi.object({
    sassLoader: Joi.any(),
  }),
});
