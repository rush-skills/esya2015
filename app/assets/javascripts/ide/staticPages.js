var apiEndpoint = "/m/static_pages.json";
$.get(apiEndpoint, function(data) {
	// ---- hardcoding for testing
	// data = [{"id":1,"name":"About","url":"http://192.168.64.194:3000/m/static_pages/1.json"},{"id":2,"name":"Some other page","url":"http://192.168.64.194:3000/m/static_pages/2.json"}]
	//-----
	data.forEach(function(entry) {
		var entry_html = "<li data-page=\"page\" data-code=\""+entry.short_code+"\" class=\"file  nav_entry\"><s class=\"fi-page\"></s> <a href=\""+ entry.url +"\">" + entry.name + "</a></li>";
  	// console.log(entry);
		$(".tree > li > ol").prepend(entry_html);
	});
  var entry_html = "<li data-page=\"page\" data-code=\"sponsors\" class=\"file  nav_entry\"><s class=\"fi-page\"></s> <a href=\""+ "/m/sponsors.json" +"\">" + "Sponsors"+ "</a></li>";
    // console.log(entry);
  $(".tree > li > ol").prepend(entry_html);
});