(function init_page() {
	// Only use this script to hide elements that need initially hidden on
	// the page. Everything else should be done asyncronously.
	document.addEventListener("load", function on_page_ready() {
		var content = document.getElementById("content");

		if (typeof content != 'undefined')
			content.style.display = "none";
	});
})();
