$(document).on('ready',function(){

var apiEndpoint = "/m/events.json";
$.get(apiEndpoint, function(data) {
	data.forEach(function(entry) {
    	category_selector = "#" + entry.category + "_events";
        category = entry.category;
        if(category == "Non Tech")
        {
            category_selector = "#Non_tech_events";
            category = "Non_tech"
        }
    		var entry_html = "<li data-category=\""+category +"\" data-page=\"event\" data-code=\""+entry.short_code+"\" class=\"file event_link\"><s class=\"fi-page\"></s> <a href=\""+ entry.url +"\">" + entry.name + "</a></li>";
		$(category_selector).prepend(entry_html);
	});
});
});