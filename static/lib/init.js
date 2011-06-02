(function init_page() {
	var listen; // Keep this file minimal. It's not loaded asynconously.
	if (document.addEventListener)
		listen = function(evt, handler, method) {
			return document.addEventListener(evt, handler, method);
		}
	else
		listen = function(evt, handler) {
			return window.attachEvent('on'+evt, handler);
		}
	listen("load", (function on_page_ready() {
		var i, body = document.getElementsByTagName('body');
		for (i=0; i < body.length; ++i) body[i].className = 'scripted';
	}), true);
})();
