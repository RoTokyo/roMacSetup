'use strict';

module.exports = function(grunt) {

	require('time-grunt')(grunt);	// Show elapsed time after tasks run
  require('jit-grunt')(grunt);	// Load all Grunt tasks

  grunt.initConfig({
  	app: {
    	source: 'source',
      dest:   'KaFWebSite',
      baseurl: ''
		},									// Variables

    clean: {
      files: {
        dot: true,
        src: ['.sass-cache', 'dest', '<%= app.dest %>/*', '!<%= app.dest %>/*.git']}},								// Clean distribution files

    jekyll: {
    	build: {
      	options: {
        	config: '_config.yml',
        	drafts: false,
        	future: false,
        	bundleExec: true,
        	src:    '<%= app.source %>',
          dest: '<%= app.dest %>'}}},							// Build Jekyll site

		uncss: {
    	options: {
    		nonull: true,
      	htmlroot: '<%= app.dest %>/<%= app.baseurl %>',
        report: true},
      build: {
      	src: '<%= app.dest %>/<%= app.baseurl %>/**/*.html',
        dest: '<%= app.dest %>/<%= app.baseurl %>/assets/css/main.css'}},								// Get rid of unused CSS

		autoprefixer: {
    	options: {
      	browsers: ['last 3 versions']},
      build: {
      	files: [{
        	expand: true,
          	cwd: '<%= app.dest %>/<%= app.baseurl %>/assets/css',
            src: '**/*.css',
            dest: '<%= app.dest %>/<%= app.baseurl %>/assets/css'}]}},				// Add vendor prefixes

    critical: {
    	build: {
      	options: {
        	base: './',
					css: '<%= app.dest %>/<%= app.baseurl %>/assets/css/main.css',
          inline: true,
          extract: false
					},
      	src: ['<%= app.dest %>/<%= app.baseurl %>/**/*.html'],
        dest: '<%= app.baseurl %>'}},						// To install require osx v. 10.10 up

		cssmin: {
    	build: {
      	options: {
          sourceMap: true,
          level: 1,
        	keepSpecialComments: 0,
          check: 'gzip'},
        files: [{
        	expand: true,
          cwd: '<%= app.dest %>/<%= app.baseurl %>/assets/css',
          src: ['*.css'],
          dest: '<%= app.dest %>/<%= app.baseurl %>/assets/css'}]}},							// Minify & gzip CSS

    htmlmin: {
    	build: {
      	options: {
        	removeComments: true,
          collapseWhitespace: true},
        files: [{
        	expand: true,
          cwd: '<%= app.dest %>/<%= app.baseurl %>',
          src: '**/*.html',
          dest: '<%= app.dest %>/<%= app.baseurl %>'}]}},							// Minify HTML

		uglify: {
    		build: {
        	options: {
          	compress: true,
            preserveComments: false,
            report: 'min'},
          files: {
          	'<%= app.dest %>/<%= app.baseurl %>/assets/js/functions.js': ['<%= app.dest %>/<%= app.baseurl %>/assets/js/**/*.js']}}},							// Minify Javascript

    imageoptim: {
      options: { quitAfter: true },
      allPngs: {
        options: {
          imageAlpha: true,
          jpegMini: false},
        src: ['<%= app.dest %>/<%= app.baseurl %>/assets/images/**/*.{png}']
      },
      allJpgs: {
        options: {
          imageAlpha: false,
          jpegMini: true},
        src: ['<%= app.dest %>/<%= app.baseurl %>/assets/images/**/*.{jpg,jpeg,gif}']
      }},    // Minify images

    svgmin: {
    	build: {
      	files: [{
        	expand: true,
          cwd: '<%= app.dest %>/<%= app.baseurl %>/assets/images',
          src: '**/*.svg',
          dest: '<%= app.dest %>/<%= app.baseurl %>/images'}]}}								// Minify svg
	});

	// Define Tasks

	grunt.registerTask('jekyllProduction', function() {
  	grunt.log.writeln('Setting environment variable JEKYLL_ENV=production');
    process.env.JEKYLL_ENV = 'production';
    grunt.task.run('jekyll:build');
  });     // Task production

  grunt.registerTask('build', [
    'clean',
    'jekyllProduction',
    //'uncss',
    'autoprefixer',
    'critical',
    'cssmin',
    'htmlmin',
    'uglify',
    //'imageoptim:allPngs',
    //'imageoptim:allJpgs'
    //'svgmin'
  ]);			// Task build production

	grunt.registerTask('serve', function(target) {
		grunt.log.warn('Grunt tasks `grunt serve` or `grunt server` NOT IN USE. Only `grunt build` tasks present.');
		grunt.task.run(['build']);
    });			// Not in use

  grunt.registerTask('default', ['build']);

};
