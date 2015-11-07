const gulp = require('gulp'),
      path = require('path'),
      tsconfig = require('./tsconfig.json'),
      plugins = require('gulp-load-plugins')(),
      browserSync = require('browser-sync').create();


PUBLIC_PATH = 'dist';


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


gulp.task('systemjs:crap', function () {
  gulp.src('node_modules/systemjs/dist/system-polyfills.js')
    .pip(gulp.dest(publicPath()));
});

gulp.task('scripts', function () {
  var tsFilter = plugins.filter('**.ts', {
    restore: true,
  });

  gulp.src([
    'node_modules/systemjs/dist/system.js',
    'src/components/*.ts',
  ], {base: path.join(__dirname, 'src')})
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
