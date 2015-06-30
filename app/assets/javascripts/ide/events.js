var apiEndpoint = "/m/events.json";
$.get(apiEndpoint, function(data) {
	// ---- hardcoding for testing
	// data = [{"id":1,"name":"Sample event 1","category":"CSE","url":"http://192.168.64.194:3000/m/events/1.json"}];
	//-----
	data.forEach(function(entry) {
		category_selector = "#" + entry.category + "_events";
    if(entry.category == "Non Tech")
    {
        category_selector = "#Non_tech_events";
    }
    // var entry_html = "<li class=\"file nav_entry\"><s class=\"fi-page\"></s> <a href=\""+ entry.url +"\">" + entry.name + "</a></li>";
		var entry_html = "<li data-page=\"event\" data-code=\""+entry.short_code+"\" class=\"file event_link\"><s class=\"fi-page\"></s> <a href=\""+ entry.url +"\">" + entry.name + "</a></li>";
    // var entry_html='<li><label for="eventfolder'
    //               +entry.id+'"><s class="fi-folder"></s>'
    //               +entry.name+'</label> <input type="checkbox" id="eventfolder'
    //               +entry.id+'" /><ol><li class="file event_link" data-field="combined"><s class="fi-page"></s><a href="'
    //               + entry.url +'">Info</a></li><li class="file event_link" data-field="description"><s class="fi-page"></s> <a href="'
    //               + entry.url +'">Description</a></li><li class="file event_link" data-field="rules"><s class="fi-page"></s> <a href="'
    //               + entry.url +'">Rules</a></li><li class="file event_link" data-field="judging"><s class="fi-page"></s> <a href="'
    //               + entry.url +'">Judging</a></li><li class="file event_link" data-field="prizes"><s class="fi-page"></s> <a href="'
    //               + entry.url +'">Prizes</a></li><li class="file event_link" data-field="contact"><s class="fi-page"></s> <a href="'
    //               + entry.url +'">Contact</a></li></ol></li>'
  	// console.log(entry);
		$(category_selector).prepend(entry_html);
	});
});