const path = require('path'),
			ExtractTextPlugin = require('extract-text-webpack-plugin'),

	    extractStyles = new ExtractTextPlugin('[contenthash].css'),
			extractMarkup = new ExtractTextPlugin('mk.html');


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
			loader: extractStyles.extract(['css', 'sass']),
		}],
	},

	plugins: [
		extractStyles,
		extractMarkup,
	],
}];
