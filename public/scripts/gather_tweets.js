// TODO: Add Failure Handlers
$(document).ready(function() {
	
	// Load Step 1
	$.get('/tweets/step1', function(data) {
		$('#step').html(data);
		$("#loading").hide("slow");
		$("#step").show("slow");
	});
	
});

function getLatestTweets (user) {
	// Get Latest Tweets
	$.get("/tweets/latest/" + user, function(data) {
		$('#results').html(data);
		$("#loading_tweets").hide("slow");
		$("#results").show("slow");
	});
}
