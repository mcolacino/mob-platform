'use strict'

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      compile:
        options:
          join: true
          sourceMap: true
        files:
          'app/js/<%= pkg.name %>.js': [
            'src/coffee/app.coffee'
          ]
    uglify:
      'mob-platform':
        options:
          sourceMap: true
          sourceMapIn: 'app/js/<%= pkg.name %>.js.map'
          compress: true
          beautify: false
        files:
          'app/js/<%= pkg.name %>.min.js': 'app/js/<%= pkg.name %>.js'
          'app/js/<%= pkg.name %>.<%= pkg.version %>.min.js': 'app/js/<%= pkg.name %>.js'
    less:
      development:
        files:
          'app/css/<%= pkg.name %>.css': ['src/less/<%= pkg.name %>.less']
      dist:
        options:
          cleancss: true
          sourceMap: true
          sourceMapFilename: 'app/css/mob-platform.min.css.map'
        files:
          'app/css/<%= pkg.name %>.min.css': 'src/less/<%= pkg.name %>.less'
          'app/css/<%= pkg.name %>.<%= pkg.version %>.min.css': 'src/less/<%= pkg.name %>.less'
    watch:
      scripts:
        files: ['src/coffee/**/*.coffee']
        tasks: ['coffee', 'uglify']
        options:
          spawn: false
      styles:
        files: ['src/less/*.less']
        tasks: ['less', 'copy:dist-stylesheets']
        options:
          spawn: false

  # Load plugins
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-uglify')

  # Default task(s).
  grunt.registerTask('default', ['coffee', 'uglify', 'less'])
