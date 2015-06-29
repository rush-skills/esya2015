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