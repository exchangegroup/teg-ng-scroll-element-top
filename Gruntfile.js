module.exports = function(grunt) {
  require('load-grunt-tasks')(grunt);

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffee: {
      compile: {
        files: {
          'dist/<%= pkg.name %>.js': 'src/<%= pkg.name %>.coffee'
        }
      }
    },
    ngmin: {
      directives: {
        src: ['dist/<%= pkg.name %>.js'],
        dest: 'dist/<%= pkg.name %>.js'
      }
    },
    uglify: {
      my_target: {
        files: {
          'dist/<%= pkg.name %>.min.js': ['dist/<%= pkg.name %>.js']
        }
      }
    },
    karma: {
      unit: {
        configFile: 'karma.conf.js',
        singleRun: true
      }
    },
    watch: {
      coffee: {
        files: ['src/{,*/}*.coffee'],
        tasks: ['build']
      },
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          'app/{,*/}*.html',
          'dist/<%= pkg.name %>.min.js'
        ]
      }
    },
    connect: {
      options: {
        port: 9000,
        // Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost',
        livereload: 35729
      },
      livereload: {
        options: {
          open: true,
          base: [
            'dist',
            'app'
          ]
        }
      },
    }
  });

  grunt.registerTask('build', ['coffee', 'ngmin', 'uglify']);

  grunt.registerTask('serve', ['build', 'connect:livereload', 'watch']);

  grunt.registerTask('test', ['karma']);

  grunt.registerTask('default', ['test', 'build']);
};