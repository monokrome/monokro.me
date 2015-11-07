const gulp = require('gulp'),
      path = require('path'),
      tsconfig = require('./tsconfig.json'),
      plugins = require('gulp-load-plugins')();


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
    .pipe(gulp.dest(publicPath()))
});


gulp.task('scripts', function () {
  gulp.src('src/components/*.ts', {
    base: path.join(__dirname, 'src'),
  })
    .pipe(plugins.typescript(tsconfig.compilerOptions))
    .pipe(plugins.concat('index.js'))
    .pipe(gulp.dest(publicPath()))
});


gulp.task('default', [
  'scripts',
  'stylesheets',
  'markup',
]);
