
window.onload = function() {
	
	var login = document.getElementById("LOGINWindow");
	// to close the window
	var close = document.querySelector('.closeWindow');
	//button
	var showwin = document.getElementById("signup");
	// showWindow
	showwin.onclick = function() {
		login.style.display = "block";
	}
	// closeWindow
	login.onclick = function() {
		login.style.display = "none";
	}
	// closeWindow
	window.onclick = function(event) {
		if(event.target == login) {
			login.style.display = "none";
		}
	}

}