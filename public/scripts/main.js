function getStep1() {
	$("#step").hide("slow");
	$("#loading").show("slow");
	// Load Step 1
	$.get('/tweets/step1', function(data) {
		$('#step').html(data);
		$("#loading").hide("slow");
		$("#step").show("slow");
	});
}

function getLatestTweets (user) {
	// Get Latest Tweets
	$.get("/tweets/latest/" + user, function(data) {
		$('#results').html(data);
		$("#loading_tweets").hide("slow");
		$("#results").show("slow");
	});
}

function getStep2 () {
	$("#step").hide("slow");
	$("#loading").show("slow");

	// Load Step 2
	$.get('/tweets/step2', function(data) {
		$('#step').html(data);
		$("#loading").hide("slow");
		$("#step").show("slow");
	});
}

function getInterestingness(user_id) {
	$.get("/tweets/process/" + user_id, function(data) {
		$('#results').html(data);
		$("#calculating").hide("slow");
		$("#results").show("slow");
	});
}

function getLongUrl (url, link_id) {
	// Get long URL
	$("#long_url_link_" + link_id).html("");
	$.getJSON('http://api.longurl.org/v2/expand?url=' + url + '&format=json&callback=?', function(data) {
		$("#short_url_" + link_id).html(data["long-url"]);
	});
}

function submitFormToInstapaper() {
	var username = $("#instapaper_username").val();
	var password = $("#instapaper_password").val();
	var url = escape($("#instapaper_url").val());
	var title = $("#instapaper_title").val();
	
	$.getJSON('https://www.instapaper.com/api/add?username=' + username + '&password=' + password + '&url=' + url + '&title=' + title + '&jsonp=?', function(data) {
		if (data.status == 201 || data.status == 200) {
			$("#instapaper_dialog").dialog('close');
			$("#instapaper_title").val("");
			$("#instapaper_url").val("");
			$("#instapaper_error").html("");
		}
		else {
			$("#instapaper_error").html("Failed with response " + data.status);
		};
	});
	
	
}

function showInstapaperForm(url) {
	$("#instapaper_url").val(url);
	$("#instapaper_dialog").dialog('open');
}