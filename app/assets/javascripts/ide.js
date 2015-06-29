// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require ide/parser_rules/advanced
//= require ide/dist/wysihtml5-0.3.0
//= require ide/vendor/modernizr
//= require ide/terminal
//= require ide/staticPages
//= require ide/events
//= require ide/pageContent

$(function(){
  $(document).foundation();

 editor = new wysihtml5.Editor("wysihtml5-editor", {
    toolbar:     "wysihtml5-editor-toolbar",
    stylesheets: ["/css/reset.css", "/css/editor.css"],
    parserRules: wysihtml5ParserRules
  });

  editor.on("load", function() {
    var composer = editor.composer;
    composer.selection.selectNode(editor.composer.element.querySelector("h1"));
  });

  jQuery(function($, undefined) {
    $('#commandLine').terminal(function(command, term) {
      if (command !== '') {
        try {
          var result = window.eval(command);
          if (result !== undefined) {
            term.echo(new String(result));
          }
        } catch(e) {
          term.error(new String(e));
        }
      } else {
       term.echo('');
     }
   }, {
    greetings: 'Welcome to ESYA\nType ? for help',
    name: 'js_demo',
    prompt: 'you@esya.iiitd.ac.in> '});
  });
});