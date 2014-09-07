var changed    = require('gulp-changed');
var gulp       = require('gulp');
var imagemin   = require('gulp-imagemin');

gulp.task('audio', function() {
  var dest = './build/audio';

  return gulp.src('./src/audio/**')
    .pipe(gulp.dest(dest));
});
