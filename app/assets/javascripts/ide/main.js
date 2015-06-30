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
      load();
      if(command == 'ls'){
        if(current_directory==root_directory){
          // term.echo([pages.join(' ')],{color: "lightskyblue"});
          term.echo("[[;red;black]"+pages.join('] [[;red;black]')+ "] [[;blue;black]"+categories.join('] [[;blue;black]')+"]" );

          // [[guib;<COLOR>;<BACKGROUND>]some text]
          // term.echo([categories.join(' ')],{color: "red"})
        }
      }
      else if (command !== '') {
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


function load(){
  root_directory = "/esya15/";
  current_directory = "/esya15/";
  categories = ["CSE","ECE","Flagship","Non_tech","School","Workshop"];
  events = [];
  $('.event_link').each(function(){
    events.push($(this).attr('data-code'));
  });
  pages = [];
  $('.nav_entry').each(function(){
    pages.push($(this).attr('data-code'));
  });
  function eventFilter(category){
    cat_events = [];
    $('.event_link[data-category='+category+']').each(function(){
      cat_events.push($(this).attr('data-code'));
    });
    return cat_events;
  }
}



function load2(){
  function load(){
  root_directory = "/esya15/";
  current_directory = "/esya15/";
  categories = ["CSE","ECE","Flagship","Non_tech","School","Workshop"];
  events = [];
  $('.event_link').each(function(){
    events.push($(this).find('a').html());
  });
  event_ids = new Object();
  $('.event_link').each(function(){
    event_ids[$(this).find('a').html()]=$(this).attr('data-code');
  });
  pages = [];
  $('.nav_entry').each(function(){
    pages.push($(this).find('a').html());
  });
  page_ids = new Object();
  $('.nav_entry').each(function(){
    page_ids[$(this).find('a').html()]=$(this).attr('data-code');
  });
  function eventFilter(category){
    cat_events = [];
    $('.event_link[data-category='+category+']').each(function(){
      cat_events.push($(this).find('a').html());
    });
    return cat_events;
  }
  function getEventCode(event)
  {
    return event_ids[event];
  }
}
}