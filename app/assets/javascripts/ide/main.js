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
    state = 0;
    termi = $('#commandLine').terminal(function(command, term) {
      load();
      if(state==0)
      {
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
      }

      //Registration Commands
      else if(state == 1){
        if(command == "Y" || command == "y")
        {
          term.echo("Registering...");
          event_id = $("#register").attr("data-event-id");
          $.get("/register/"+event_id+".json", function(data) {
            term.echo(data["data"]);
            if(data["data"] == "Success")
            {
              $('#register').html("Registered");
              $('#register').attr("data-registered","1");
            }
            unFocusTerminal();
            term.set_prompt('you@esya.iiitd.ac.in: '+current_directory+"> ");
            state = 0;
          });
        }
        else{
          term.echo("Cancelling...");
          unFocusTerminal();
          term.set_prompt('you@esya.iiitd.ac.in: '+current_directory+"> ");
          state = 0;
        }

      }

      //Profile commands
      else if(state == 2){
        name_prompt = "[[;red;black]Name: ]";
        email_prompt = "[[;red;black]Email: ]";
        college_prompt = "[[;red;black]College: ]";
        phone_prompt = "[[;red;black]Phone: ]";
        data =  $.ajax({
            type: "GET",
            url: "/m/profile.json",
            cache: false,
            async: false
        }).responseJSON;
        name = data["name"];
        if(name == null){
          name = "";
        }
        email = data["email"];
        if(email == null)
        {
          email = "";
        }
        college = data["college"];
        if(college == null)
        {
          college = "";
        }
        phone = data["phone"];
        if(phone == null){
          phone = "";
        }
        if(command != ""){
          if(term.get_prompt() == name_prompt)
          {
            name = command;
            term.echo("New name = "+name);
            $.ajax({
                url: "/m/profile/update.json",
                type: "POST",
                data: {"participant": {
                         "name": name}},
                success: function(resp){
                }
            });
            $('#login a').first().html(name);
            term.set_prompt(email_prompt);
            term.set_command(email);
          }
          else if(term.get_prompt() == email_prompt)
          {
            email = command;
            term.echo("New email = "+email);
            $.ajax({
                url: "/m/profile/update.json",
                type: "POST",
                data: {"participant": {
                         "email": email}},
                success: function(resp){
                }
            });
            term.set_prompt(college_prompt);
            term.set_command(college);
          }
          else if(term.get_prompt() == college_prompt)
          {
            college = command;
            term.echo("New college = "+college);
            $.ajax({
                url: "/m/profile/update.json",
                type: "POST",
                data: {"participant": {
                         "college": college}},
                success: function(resp){
                }
            });
            term.set_prompt(phone_prompt);
            term.set_command(phone);
          }
          else if(term.get_prompt() == phone_prompt)
          {
            phone = command;
            term.echo("New phone = "+phone);
            $.ajax({
                url: "/m/profile/update.json",
                type: "POST",
                data: {"participant": {
                         "phone": phone}},
                success: function(resp){
                }
            });
            // term.set_prompt(phone_prompt);
            // term.set_command(phone);

            unFocusTerminal();
            term.set_prompt('you@esya.iiitd.ac.in: '+current_directory+"> ");
            state = 0;
          }
        }
      }
    },
    {
      greetings: 'Welcome to ESYA\nType ? for help',
      name: 'js_demo',
      prompt: 'you@esya.iiitd.ac.in: '+current_directory+"> "
    });

    function load(){
      categories = ["Techathlon","CSE","ECE","Flagship","Non_tech","School","Workshop"];
      events = [];
      $('.event_link').each(function(){
        events.push($(this).attr('data-code'));
      });
      pages = [];
      $('.nav_entry').each(function(){
        pages.push($(this).attr('data-code'));
      });
    }

    reg = $("#register");
    reg.click(function(e){
      e.preventDefault();
      // alert('clicked');
      if(reg.attr("data-registered")=="0")
      {
        termi.clear();
        focusTerminal();
        login = $('#login').attr('data-logged-in');
        if(login == '1')
        {
          termi.echo("[[;red;black]Are you sure you want to register for the event:] [[;green;black]"+reg.attr('data-event-name')+"]");
          termi.set_prompt('Enter Y to confirm, any other key to cancel: ');
          state=1;
        }
        else
        {
          termi.echo("[[;red;black]You need to login to continue]");
          unFocusTerminal();
          $('#login a').first().click();
        }
      }
      else{
        termi.echo("Alredy Registered for the event");
      }
    });

    profile = $('#profile');
    profile.click(function(e){
      e.preventDefault();
      focusTerminal();
      termi.clear();
      termi.echo("[[;green;black]Here are the details of your profile we have, you can edit them if you like.]");
      state = 2;
      name_prompt = "[[;red;black]Name: ]";
      termi.set_prompt(name_prompt);
      termi.set_command($('#login a').first().html());
    })
    function focusTerminal(){
      $("#top_part").css("height","50%");
      $("#term_part").css("height","47%");
      $('#file_tabs').css("height","10%");
      $("#editor_area").css("height","90%");
    }
    function unFocusTerminal(){
      $("#top_part").css("height","75%");
      $("#term_part").css("height","22%");
      $("#editor_area").css("height","93%");
      $('#file_tabs').css("height","");
    }


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
    if(pageUrl.length<3)
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
  });
});