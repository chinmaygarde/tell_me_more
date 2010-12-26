function getInterestingness(user_id) {
	$.get("/tweets/process/" + user_id, function(data) {
		$('#results').html(data);
		$("#calculating").hide("slow");
		$("#results").show("slow");
	});
}
