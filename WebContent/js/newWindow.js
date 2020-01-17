window.onload=function(){
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
	var newWindow = document.getElementById("myWindow");
	var newWindow2 = document.getElementById("myWindow2");
	// to close the window
	var span = document.querySelector('.close');
	var span2 = document.querySelector('.close2');
	var show = document.getElementById("link");
	var show2 = document.getElementById("link2");
	// 点击按钮打开弹窗
	show.onclick = function() {
		newWindow.style.display = "block";
	}
	show2.onclick = function() {
		newWindow2.style.display = "block";
	}
	// 点击 <span> (x), 关闭弹窗
	span.onclick = function() {
		newWindow.style.display = "none";
	}
	span2.onclick = function() {
		newWindow2.style.display = "none";
	}
	// 在用户点击其他地方时，关闭弹窗
	window.onclick = function(event) {
		if(event.target == newWindow) {
			newWindow.style.display = "none";
		}
	}

	// 在用户点击其他地方时，关闭弹窗
	window.onclick = function(event) {
		if(event.target == newWindow2) {
			newWindow2.style.display = "none";
		}
	}
}
