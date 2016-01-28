const ExtractTextPlugin = require('extract-text-webpack-plugin'),

			autoprefixer = require('autoprefixer'),
			path = require('path'),

	    extractStyles = new ExtractTextPlugin('main.css', { allChunks: true }),
			extractMarkup = new ExtractTextPlugin('index.html');


module.exports = [{
	entry: './src/main.js',

	output: {
			path: path.join(__dirname, '/dist/'),
			filename: 'main.js',
	},

	module: {
		loaders: [{
			test: /\.js$/,
			loader: 'babel',

			query: {
				presets: ['es2015'],
			}

		}, {
			test: /\.html$/,
			loader: extractMarkup.extract('html?interpolate'),

		}, {
			test: /\.scss$/,
			loader: extractStyles.extract(['css', 'postcss', 'sass']),
			postcss: () => { return [autoprefixer]; },
		}],
	},

	plugins: [extractStyles, extractMarkup],
}];
