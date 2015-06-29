var apiEndpoint = "http://localhost:3000/m/events.json";
$.get(apiEndpoint, function(data) {
	// ---- hardcoding for testing
	// data = [{"id":1,"name":"Sample event 1","category":"CSE","url":"http://192.168.64.194:3000/m/events/1.json"}];
	//-----
	data.forEach(function(entry) {
		var category_selector = "#" + entry.category + "_events";
		var entry_html = "<li class=\"file nav_entry\"><s class=\"fi-page\"></s> <a href=\""+ entry.url +"\">" + entry.name + "</a></li>";
    	console.log(entry);
		$(category_selector).prepend(entry_html);
	});
});