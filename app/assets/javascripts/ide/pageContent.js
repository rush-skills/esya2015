$(document).on('ready',function(){
	function pushElement(x){
		//remove prefix when website is shifted to root domains
		prefix = "";

		type = x.attr("data-page");
		code = x.attr("data-code");
		origPath = window.location.pathname;
		newPath = prefix + "/" + type + "/" + code;
		if(newPath != origPath){
			history.pushState(null, null, prefix + "/" + type + "/" + code);
		}
	}
	$(document).on('click',".nav_entry",function(e) {
		e.preventDefault();
		x = $(this);

		//hide register button
		$('#register').hide();

		var apiEndpoint = x.find("a").attr('href');
		pushElement(x);
		$.get(apiEndpoint, function(data) {
			editor.setValue(data.combined, true);
			$('#first_tab').html(data["name"]);
		});
	});
	$(document).on('click',".event_link",function(e) {
		e.preventDefault();
		var x = $(this);

		//show register button
		$('#register').show();
		var apiEndpoint = x.find("a").attr('href');
		pushElement(x);
		category = x.attr("data-category");
		$.get(apiEndpoint, function(data) {
		  type = "combined";
			editor.setValue(data[type], true);
			$('#first_tab').html(category + " | " + data["name"]);
			$('#register').attr("data-event-id",data["id"]);
			$('#register').attr("data-event-name",data["name"]);
			$('#register').attr("data-registered",data["registered"]);
			$('#register').attr("data-team-event",data["team_event"]);
			$('#register').attr("data-team-id",data["team_id"]);
			$('#register').attr("data-team-size",data["current_team_size"]);

			if(data["registered"] == "1"){
				$('#register').html("Registered");
			}
			else{
				$('#register').html("Register");
			}
		});
	});
});