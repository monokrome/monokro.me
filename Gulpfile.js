const gulp = require('gulp'),
      path = require('path'),
      tsconfig = require('./tsconfig.json'),
      plugins = require('gulp-load-plugins')(),
      through2 = require('through2'),
      browserSync = require('browser-sync').create();


PUBLIC_PATH = 'dist';


function endsWithFactory(str) {
  return function (file) {
    return file.relative.indexOf(str) == file.relative.length - str.length;
  }
}


function makeArray(items) {
  var index, result = [];
  for (index in items) result.push(items[index]);
  return result;
}


function publicPath() {
  var suffix = path.join.apply(this, arguments);
  return path.join.call(this, PUBLIC_PATH, suffix);
}


gulp.task('markup', function () {
  gulp.src('src/**.html')
    .pipe(gulp.dest(publicPath()))
});


gulp.task('stylesheets', function () {
  gulp.src('src/**.css')
    .pipe(gulp.dest(publicPath()));
});


gulp.task('systemjs:polyfill', function () {
  gulp.src('node_modules/systemjs/dist/system-polyfills.js')
    .pipe(gulp.dest(publicPath()));
});
 

gulp.task('scripts', ['systemjs:polyfill'], function () {
  var tsFilter = plugins.filter(endsWithFactory('.ts'), {
    restore: true,
  });

  gulp.src([
    'node_modules/systemjs/dist/system.js',
    'node_modules/angular2/bundles/typings/angular2/angular2.d.ts',
    'src/components/*.ts',
  ], {
    base: __dirname,
  })
    .pipe(tsFilter)
    .pipe(plugins.typescript(tsconfig.compilerOptions))
    .pipe(tsFilter.restore)
    .pipe(plugins.concat('index.js'))
    .pipe(gulp.dest(publicPath()));
});


gulp.task('once', [
  'scripts',
  'stylesheets',
  'markup',
])


gulp.task('server', ['once'], function () {
  browserSync.init({
    server: publicPath(),
    open: false,
  })
});


gulp.task('default', ['once']);
