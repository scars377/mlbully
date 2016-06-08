gulp = require 'gulp'
$ = require('gulp-load-plugins')()




###
███████  ██████  ███    ██ ████████ ███    ███ ██ ███    ██
██      ██    ██ ████   ██    ██    ████  ████ ██ ████   ██
█████   ██    ██ ██ ██  ██    ██    ██ ████ ██ ██ ██ ██  ██
██      ██    ██ ██  ██ ██    ██    ██  ██  ██ ██ ██  ██ ██
██       ██████  ██   ████    ██    ██      ██ ██ ██   ████
###
gulp.task 'fontmin',->
	src = 'src/assets/font-src'
	tar = 'src/assets/font'

	fs = require 'fs'
	fontmin = require 'gulp-fontmin'

	files = fs.readdirSync src

	for f in files when f.match(/.ttf$/i)?
		fontSrc = src+'/'+f
		textSrc = fontSrc.replace /.ttf$/i,'.txt'
		opt = {fontPath:'', hinting: false}

		try
			opt.text = fs.readFileSync textSrc,'utf8'

		gulp.src fontSrc
			.pipe fontmin opt
			.pipe gulp.dest tar

gulp.task 'f',['fontmin']





###
██ ███    ███  █████   ██████  ███████ ███    ███ ██ ███    ██
██ ████  ████ ██   ██ ██       ██      ████  ████ ██ ████   ██
██ ██ ████ ██ ███████ ██   ███ █████   ██ ████ ██ ██ ██ ██  ██
██ ██  ██  ██ ██   ██ ██    ██ ██      ██  ██  ██ ██ ██  ██ ██
██ ██      ██ ██   ██  ██████  ███████ ██      ██ ██ ██   ████
###

gulp.task 'imagemin',->
	src = 'src/assets/img-src/**/*.*'
	tar = 'src/assets/img/'

	imageminPngquant = require 'imagemin-pngquant'
	imageminMozjpeg  = require 'imagemin-mozjpeg'

	gulp.src src
		.pipe $.changed tar
		.pipe $.size {
			title: 'image src'
			showFiles:true
		}
		.pipe $.if '*.png',imageminPngquant(quality:'65-80', speed:4)()
		.pipe $.if '*.jpg',imageminMozjpeg(quality: 80)()
		.pipe gulp.dest tar
		.pipe $.size {
			title: 'image tar'
		}


gulp.task 'm',['imagemin']








###
██████  ██████   ██████  ██████  ██    ██  ██████ ████████ ██  ██████  ███    ██
██   ██ ██   ██ ██    ██ ██   ██ ██    ██ ██         ██    ██ ██    ██ ████   ██
██████  ██████  ██    ██ ██   ██ ██    ██ ██         ██    ██ ██    ██ ██ ██  ██
██      ██   ██ ██    ██ ██   ██ ██    ██ ██         ██    ██ ██    ██ ██  ██ ██
██      ██   ██  ██████  ██████   ██████   ██████    ██    ██  ██████  ██   ████
###
gulp.task 'webpack-build',(cb)->
	require 'coffee-script/register'
	webpack = require 'webpack'
	webpackConfig = require './webpack.config.coffee'

	webpackConfig.plugins.push(
		new webpack.DefinePlugin('process.env':{'NODE_ENV': '"production"'})
		new webpack.optimize.DedupePlugin()
		new webpack.optimize.UglifyJsPlugin({compress:{warnings:false}})
	)

	webpack webpackConfig,(err, stats)->
		if err? then throw new Error(err.message)
		console.log stats.toString {
			colors: true
			chunkModules:false
		}

		cb()


gulp.task 'p', ['webpack-build'],->
	# diff
	return gulp.src 'dist/**'
  	.pipe $.changed 'dist_remote', {hasChanged: $.changed.compareSha1Digest}
		.pipe $.if '*.aspx',$.bom()
		.pipe gulp.dest 'dist_remote'
		.pipe $.size {
			title: 'diff'
			showFiles:true
		}

gulp.task 'pp',['p'], (cb)->
	require('child_process').exec('ftp.cmd')
	# path from where u call gulp pp










###
██████  ███████ ██    ██ ███████ ██       ██████  ██████
██   ██ ██      ██    ██ ██      ██      ██    ██ ██   ██
██   ██ █████   ██    ██ █████   ██      ██    ██ ██████
██   ██ ██       ██  ██  ██      ██      ██    ██ ██
██████  ███████   ████   ███████ ███████  ██████  ██
###
gulp.task 'webpack-dev-server', (cb)->
	host = 'localhost'
	port = 3000

	require 'coffee-script/register'
	webpack = require 'webpack'
	webpackDevServer = require 'webpack-dev-server'
	webpackConfig = require './webpack.config.coffee'

	webpackConfig.devtool = 'cheap-module-eval-source-map'
	for name,entry of webpackConfig.entry
		entry.push "webpack-dev-server/client?http://#{host}:#{port}"

	# hot
	# webpackConfig.devServer.hot = true
	# webpackConfig.plugins = [new webpack.HotModuleReplacementPlugin()]
	# for name,entry of webpackConfig.entry
	# 	entry.push 'webpack/hot/dev-server'

	new webpackDevServer(
		webpack webpackConfig
		webpackConfig.devServer
	).listen port, host



gulp.task 'default',['webpack-dev-server']
