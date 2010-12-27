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