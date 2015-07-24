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
            term.echo("[[;#4288FF;black]events] [[;#4288FF;black]] [[;white;black]"+pages.join('] [[;white;black]') + "]" );
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
          team_event = $("#register").attr("data-team-event");
          if(team_event == "true"){
            term.set_prompt("[[;red;black]If you are joining another team, enter team code, else leave blank: ]");
            state = 3;
          }
          else
          {
            term.echo("Registering...");
            event_id = $("#register").attr("data-event-id");
            $.get("/m/register/"+event_id+".json", function(data) {
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
        }
        else{
          term.echo("Cancelling...");
          unFocusTerminal();
          term.set_prompt('you@esya.iiitd.ac.in: '+current_directory+"> ");
          state = 0;
        }

      }

      //Team registration commands
      else if (state == 3){
        if(command!=''){
          term.echo("Registering...");
          event_id = $("#register").attr("data-event-id");
          $.get("/m/register/"+event_id+"/" +command + ".json", function(data) {
            term.echo(data["data"]);
            term.echo("[[;green;black]" + data["extra_data"] +"]");
            if(data["data"] == "Success")
            {
              $('#register').html("Registered");
              $('#register').attr("data-registered","1");
              $('#register').attr("data-team-size",data["team_code"]);
              $('#register').attr("data-team-id",data["team_size"]);
            }
            unFocusTerminal();
            term.set_prompt('you@esya.iiitd.ac.in: '+current_directory+"> ");
            state = 0;
          });
        }
        else{
          term.set_prompt("[[;red;black]Please enter your TEAM NAME, can't be blank: ]");
          state = 4;
        }
      }
      else if(state == 4){
        if(command!='')
        {
          term.echo("Registering...");
          event_id = $("#register").attr("data-event-id");
          $.get("/m/register/"+event_id+"/team/" +command +".json", function(data) {
            term.echo(data["data"]);
            term.echo("[[;green;black]" + data["extra_data"] +"]");
            if(data["data"] == "Success")
            {
              $('#register').html("Registered");
              $('#register').attr("data-registered","1");
              $('#register').attr("data-team-size",data["team_size"]);
              $('#register').attr("data-team-id",data["team_code"]);
            }
            unFocusTerminal();
            term.set_prompt('you@esya.iiitd.ac.in: '+current_directory+"> ");
            state = 0;
          });
        }
      }
      //Profile commands
      else if(state == 2 || state == 9){
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
            if(email == "")
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
            }
            else
            {
              term.echo("[[;red;black;]Email cannot be changed!]");
            }
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

            unFocusTerminal();
            term.set_prompt('you@esya.iiitd.ac.in: '+current_directory+"> ");
            if(state == 9){
              term.clear();
              state=0;
              $('#register').click();
            }
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
      if(reg.attr("data-event-name")=="Procon Jr"){
         window.open('http://esya.iiitd.edu.in/pcj','_blank');
      }
      else{
        if(reg.attr("data-registered")=="0")
        {
          termi.clear();
          // login = $('#login').attr('data-logged-in');
          $.get("/m/profile.json", function(data) {
            login = data["login"];
            if(login)
            {
              focusTerminal();
              complete = data["complete"];
              if(complete)
              {
                termi.clear();
                termi.echo("[[;red;black]Are you sure you want to register for the event:] [[;green;black]"+reg.attr('data-event-name')+"]");
                termi.set_prompt('Type Y to confirm, any other key to cancel, and press enter: ');
                state=1;
              }
              else
              {
                state=9;
                $("#profile").click();
              }
            }
            else
            {
              termi.echo("[[;red;black]You need to login to continue]");
              $('#login a').first().click();
            }
          });
        }
        else{
          termi.echo("[[;red;black]Alredy Registered for the event!]");
          if(reg.attr("data-team-event")=="true"){
            termi.echo("[[;green;black] Your current team size is "+reg.attr("data-team-size")+". Your team code is: "+reg.attr("data-team-id")+". Use this code to add other team members.]")
          }
        }
      }
    });

    profile = $('#profile');
    profile.click(function(e){
      e.preventDefault();
      focusTerminal();
      termi.clear();
      if(state == -1)
      {
        termi.echo("[[;red;black]You need to complete your profile before registering]");
      }
      termi.echo("[[;green;black]Here are the details of your profile we have, you can edit them if you like.]");
      state = 9;
      name_prompt = "[[;red;black]Name: ]";
      termi.set_prompt(name_prompt);
      termi.set_command($('#login a').first().html());
    });
    function focusTerminal(){
      $("#top_part").css("height","50%");
      $("#term_part").css("height","47%");
      $('#file_tabs').css("height","10%");
      $("#editor_area").css("height","90%");
      $(".cmd").click();
    }
    function unFocusTerminal(){
      $("#top_part").css("height","75%");
      $("#term_part").css("height","22%");
      $("#editor_area").css("height","93%");
      $('#file_tabs').css("height","");
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
      name = pageUrl[pageUrl.length-1].split("#")[0];
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
function resetPage(){
  if($('.nav_entry').length < 1)
  {
    window.location.reload();
  }
  pushObject = $('li[data-page="page"][data-code="about"]');
  pushObject.click();
}
