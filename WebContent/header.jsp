<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page language="java" import="java.util.*,dao.*,bean.*"%>
<html>
<head>
<title>header</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/header.css" />

<script src="js/bootstrap3.0.js"></script>
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript">
	function pop() {
		var login = document.getElementById("LOGINWindow");
		login.style.display = "block";

		var closebtn = document.getElementById("closebtn");

		window.onclick = function(event) {
			if (event.target == closebtn) {
				login.style.display = "none";
			}
		}
	}
</script>
</head>
<%
	DelegationDao deleDao = new DelegationDao();
	List<String> getAllDelegationNames = deleDao.getDelegationNames();
	SportsDao sportsDao = new SportsDao();
	List<String> getAllSportsNames = sportsDao.getSportsNames();
%>
<body>
	<!-- header -->
	<div class="header">
		<div class="Olympic">
			<img src="img/olympic-games.png" id="imageOlympic" />
		</div>
		<div class="navigationbar">
			<ul>
				<li><a href="index.jsp" class="navFont">Home</a></li>

				<li>
					<div class="dropdown">
						<a href="Delegation.jsp" class="dropbtn navFont">Delegation</a>
						<div class="dropdown-content">
							<%
								for (int i = 0; i < getAllDelegationNames.size(); i++) {
							%>
							<%="<a href=DelegationServlet?delegation=" + getAllDelegationNames.get(i) + ">"
						+ getAllDelegationNames.get(i) + "</a>"%>
							<%
								}
							%>
						</div>
					</div>
				</li>

				<li>
					<div class="dropdown">
						<a href="Sports.jsp" class="dropbtn navFont">Sports</a>
						<div class="dropdown-content">
							<div class="halfside">
								<%
									for (int i = 0; i < getAllSportsNames.size(); i++) {
								%>
								<%="<a href=SportsServlet?Sports=" + getAllSportsNames.get(i) + ">"
										+ getAllSportsNames.get(i) + "</a>"%>
								<%
									}
								%>
							</div>
						</div>
					</div>
				</li>
				<li><a href="Results.jsp" class="navFont">Results</a></li>
				<li><a href="index.jsp" class="navFont">Photos&nbsp;&amp;&nbsp;News</a>
				</li>
				<li><a href="ContactUs.jsp" class="navFont">Contact Us</a></li>
				<li class="button"><a class="navFont"><button id="signup"
							onclick="pop()">SIGN UP</button></a></li>
			</ul>

		</div>
		<div id="LOGINWindow" class="LOGIN">
			<!-- content -->
			<div class="LOGINcontent">
				<!--close part-->
				<div class="windowHeader">
					<span class="closeWindow" id="closebtn">&times;</span>
					<h2>LOGIN NOW</h2>
				</div>
				<form id="loginForm" action="LoginServlet" method="GET">
					<div class="windowText" style="margin: 0 auto; text-align: center;">
						<h2>USERNAME</h2>
						<input type="text" placeholder="Enter Username" name="username" />
						<h2>PASSWORD</h2>
						<input type="password" placeholder="Enter Password"
							name="password" />
					</div>
					<div style="margin-top: 10px; text-align: center;">
						<input type="submit" id="loginButton"
							style="color: white; background-color: #5CB85C; border: none; width: 100px; height: 30px;"
							value="LOGIN!"></input>
					</div>
				</form>

			</div>

		</div>
	</div>
</body>
</html>