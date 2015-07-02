$(document).on('ready',function(){
  jQuery(function($, undefined) {
    $(document).foundation();

    editor = new wysihtml5.Editor("wysihtml5-editor", {
      toolbar:     "wysihtml5-editor-toolbar",
      stylesheets: ["/css/reset.css", "/css/editor.css"],
      parserRules: wysihtml5ParserRules
    });

    editor.on("load", function() {
      var composer = editor.composer;
      composer.selection.selectNode(editor.composer.element.querySelector("p"));
    });
    root_directory = "~/esya15";
    current_directory = "~/esya15";
    $('#commandLine').terminal(function(command, term) {
      load();
      if(command == 'ls'){
        if(current_directory==root_directory){
          // term.echo([pages.join(' ')],{color: "lightskyblue"});
          term.echo("[[;#4288FF;black]events] [[;#4288FF;black]] [[;white;black]"+pages.join('] [[;white;black]') + "]" );

          // [[guib;<COLOR>;<BACKGROUND>]some text]
          // term.echo([categories.join(' ')],{color: "red"})
        }
        else if(current_directory.split('/').length==3){
          term.echo("[[;#4288FF;black]"+categories.join('] [[;#4288FF;black]')+"]" );
        }
        else if(current_directory.split('/').length==4){
          function eventFilter(category){
            cat_events = [];
            $('.event_link[data-category='+category+']').each(function(){
              cat_events.push($(this).attr('data-code'));
            });
            return cat_events;
          }
          term.echo("[[;white;black]"+eventFilter(current_directory.split('/')[3]).join('] [[;white;black]')+ "]" );
        }
        else{
          term.error("Invalid directory! Are you a hacker?");
        }
      }
      else if(command.indexOf("cd") > -1)
      {
        folder = command.split(" ")[1];
        if(folder == ".."){
          if(current_directory==root_directory){
            term.error("Already in base directory!");
          }
          else{
            new_directory = current_directory.split('/');
            new_directory.pop();
            current_directory = new_directory.join('/');
            term.set_prompt('you@esya.iiitd.ac.in: '+current_directory+"> ");
          }
        }
        else if(current_directory.indexOf("events") > -1){
          if(categories.indexOf(folder) > -1){
            current_directory+="/"+folder;
            term.set_prompt('you@esya.iiitd.ac.in: '+current_directory+"> ");
          }
          else{
            term.error("Folder not found!");
          }
        }
        else if(current_directory==root_directory){
          if(folder=="events"){
            current_directory += "/events";
            term.set_prompt('you@esya.iiitd.ac.in: '+current_directory+"> ");
          }
          else{
            term.error("Folder not found!");
          }
        }
        else{
          term.error("Something went wrong.")
        }
      }
      else if(command == 'pwd')
      {
        term.echo(current_directory);
      }
      else if(command.indexOf("open") > -1){
        args = command.split(' ');
        file = args[1];
        if(current_directory.indexOf("events") > -1){
          pushObject = $('li[data-page='+ "event" + '][data-code=' + file + ']');
          pushObject.click();
        }
        else{
          pushObject = $('li[data-page='+ "page" + '][data-code=' + file + ']');
          pushObject.click();
        }
      }
      else if(command == '?'){
        term.echo("Welcome to Esya 15 Terminal.\nYou can use the commands 'pwd','ls','cd FOLDERNAME','open FILENAME'\nFiles are colored [[;white;black]white], folders are colored [[;#4288FF;black]blue].\nYou can even run javascript(and jQuery) in this terminal, just like the one in your browser's debugger\nWe will be adding more features soon, so watch out.\nGood luck, have fun!")
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
    prompt: 'you@esya.iiitd.ac.in: '+current_directory+"> "});

    function load(){
      categories = ["CSE","ECE","Flagship","Non_tech","School","Workshop"];
      events = [];
      $('.event_link').each(function(){
        events.push($(this).attr('data-code'));
      });
      pages = [];
      $('.nav_entry').each(function(){
        pages.push($(this).attr('data-code'));
      });
    }

  

  });
});

function resetPage(){
  if($('.nav_entry').length < 1)
  {
    window.location.reload();
  }
  pushObject = $('li[data-page="page"][data-code="about"]');
  pushObject.click();
}
function reloadPage(){
  pageUrl = window.location.pathname.split('/');
  if(pageUrl.length<4)
  {
    pushObject = $('li[data-page="page"][data-code="about"]');
    pushObject.click();
  }
  else
  {
    type = pageUrl[pageUrl.length-2];
    name = pageUrl[pageUrl.length-1];
    pushObject = $('li[data-page='+ type + '][data-code=' + name + ']');
    pushObject.click();
    // console.log(pushObject);
  }
}
window.onload = function(){
  // window.history.back();
  reloadPage();
};
window.onpopstate = function(){
  // window.history.back();
  reloadPage();
};