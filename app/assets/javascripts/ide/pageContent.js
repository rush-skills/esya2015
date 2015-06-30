$(window).load(function() {
	function pushElement(x){
		//remove prefix when website is shifted to root domains
		prefix = "/abcc";

		type = x.attr("data-page");
		code = x.attr("data-code");
		// console.log(window.location.pathname);
		origPath = window.location.pathname;
		newPath = prefix + "/" + type + "/" + code;
		// console.log(newPath != origPath);
		if(newPath != origPath)
		history.pushState(null, null, prefix + "/" + type + "/" + code);
	}
	$(".nav_entry").click(function(e) {
		e.preventDefault();
		x = $(this);

		var apiEndpoint = x.find("a").attr('href');
		// get the real path
		// var path = apiEndpoint.split("/").slice(-3);
		// path[2] = path[2].split(".")[0];
		// history.pushState(null, null, "/" + path[1] + "/" + path[2]);
		pushElement(x);
		$.get(apiEndpoint, function(data) {
		// ---- hardcoding for testing
		// data = {"id":1,"name":"About","description":"\u003ch1\u003eTitle\u003c/h1\u003e\u003cp\u003eThis is the description\u003c/p\u003e\u003cp\u003e\u003cb\u003eThis is bold\u003c/b\u003e\u003c/p\u003e\u003cp\u003e\u003ci\u003e\u003c/i\u003e\u003ci\u003eThis is italic\u003c/i\u003e\u003cbr\u003e\u003c/p\u003e\u003cp\u003e\u003ci\u003e\u003cu\u003e\u003c/u\u003e\u003c/i\u003e\u003cu\u003eThis is underlined\u003c/u\u003e\u003ci\u003e\u003cbr\u003e\u003c/i\u003e\u003c/p\u003e\u003cp\u003e\u003csmall\u003e\u003c/small\u003e\u003cu\u003e\u003csmall\u003e\u003c/small\u003e\u003c/u\u003e\u003csmall\u003e\u003c/small\u003e\u003cu\u003e\u003csmall\u003e\u003c/small\u003e\u003c/u\u003e\u003csmall\u003eThis is small\u003c/small\u003e\u003cu\u003e\u003c/u\u003e\u003c/p\u003e\u003cblockquote\u003eThis is quoted\u003c/blockquote\u003e\u003cul\u003e\u003cli\u003eul1\u003c/li\u003e\u003cli\u003eul2\u003c/li\u003e\u003c/ul\u003e\u003col\u003e\u003cli\u003eol1\u003cbr\u003e\u003c/li\u003e\u003cli\u003eol2\u003c/li\u003e\u003c/ol\u003e\u003cbr\u003e\u003cbr\u003e","created_at":"2015-06-26T13:23:18.727Z","updated_at":"2015-06-26T13:23:18.727Z"}
		//-----
			editor.setValue(data.description, true);
			$('#first_tab').html(data["name"]);
		});
	});
	$(".event_link").click(function(e) {
		e.preventDefault();
		var x = $(this);
		var apiEndpoint = x.find("a").attr('href');
		// get the real path
		// var path = apiEndpoint.split("/").slice(-3);
		// path[2] = path[2].split(".")[0];
		// history.pushState(null, null, "/" + path[1] + "/" + path[2]);
		pushElement(x);
		$.get(apiEndpoint, function(data) {
		// ---- hardcoding for testing
		// data = {"id":1,"name":"About","description":"\u003ch1\u003eTitle\u003c/h1\u003e\u003cp\u003eThis is the description\u003c/p\u003e\u003cp\u003e\u003cb\u003eThis is bold\u003c/b\u003e\u003c/p\u003e\u003cp\u003e\u003ci\u003e\u003c/i\u003e\u003ci\u003eThis is italic\u003c/i\u003e\u003cbr\u003e\u003c/p\u003e\u003cp\u003e\u003ci\u003e\u003cu\u003e\u003c/u\u003e\u003c/i\u003e\u003cu\u003eThis is underlined\u003c/u\u003e\u003ci\u003e\u003cbr\u003e\u003c/i\u003e\u003c/p\u003e\u003cp\u003e\u003csmall\u003e\u003c/small\u003e\u003cu\u003e\u003csmall\u003e\u003c/small\u003e\u003c/u\u003e\u003csmall\u003e\u003c/small\u003e\u003cu\u003e\u003csmall\u003e\u003c/small\u003e\u003c/u\u003e\u003csmall\u003eThis is small\u003c/small\u003e\u003cu\u003e\u003c/u\u003e\u003c/p\u003e\u003cblockquote\u003eThis is quoted\u003c/blockquote\u003e\u003cul\u003e\u003cli\u003eul1\u003c/li\u003e\u003cli\u003eul2\u003c/li\u003e\u003c/ul\u003e\u003col\u003e\u003cli\u003eol1\u003cbr\u003e\u003c/li\u003e\u003cli\u003eol2\u003c/li\u003e\u003c/ol\u003e\u003cbr\u003e\u003cbr\u003e","created_at":"2015-06-26T13:23:18.727Z","updated_at":"2015-06-26T13:23:18.727Z"}
		//-----
		  // type = me.attr("data-field");
		  type = "combined"
		  // console.log(type);
		  // console.log(data[type]);
			editor.setValue(data[type], true);
			$('#first_tab').html(data["category"] + " | " + data["name"]);
		});
	});
});