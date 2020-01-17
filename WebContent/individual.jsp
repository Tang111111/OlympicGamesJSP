<%@page language="java" import="java.util.*,dao.*,bean.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Individual sports details</title>
<link rel="stylesheet" type="text/css" href="css/individual.css" />
<link rel="stylesheet" type="text/css" href="css/result.css" />
<link rel="stylesheet" type="text/css" href="css/participant.css" />
<script type="text/javascript" src="js/sportsname.js"></script>
<script src="js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#page-head').load('header(1).jsp');
		$('#page-footer').load('footer(1).jsp');
	});
</script>
<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
<link rel="stylesheet" type="text/css" href="css/theme.blue.css"/>
</head>
<%
	PictureDao participantsPic = new PictureDao();
	String eventName = (String) request.getParameter("Event");
	String sportsName = (String) request.getParameter("Sports");
	List<Picture> pictures = participantsPic.getI_Participant(eventName);
	ResultDao eventNameDao = new ResultDao();
	List<String> otherSports = eventNameDao.getList(sportsName);
	List<String> otherEvents = eventNameDao.getIndiList(sportsName, eventName);
	System.out.println(eventName);
	List<Event> getEventSchedule = eventNameDao.getSchedule(eventName);
%>
<body>
	<!-- header -->
	<div id="page-head"></div>

	<div class="individual" style="font-family: 'microsoft sans serif';">
		<div class="sportsname">
			<nav class="sportsnamenav">
				<div class="container2">
					<div class="drop-down">
						<button class="dropbutton" onclick="myFunction1()"><%=sportsName%></button>
						<div class="content" id="myDropdown1">
							<%
								for (int i = 0; i < otherSports.size(); i++) {
							%>
							<%="<a href=SportsServlet?Sports="+(java.net.URLEncoder.encode(otherSports.get(i), "UTF-8")).replace("+", "%20")+" >" + otherSports.get(i) + "</a>"%> 
							<%
								}
							%>
						</div>
					</div>

					<div class="drop-down">
						<button class="dropbutton">Individual</button>
					</div>

					<div class="drop-down">
						<button class="dropbutton" onclick="myFunction2()"><%=eventName%></button>
						<div class="content" id="myDropdown2">
							<%
								for (int i = 0; i < otherEvents.size(); i++) {
							%>
							<%="<a href=IndividualServlet?Sports="+sportsName+"&Event="+(java.net.URLEncoder.encode(otherEvents.get(i), "UTF-8")).replace("+", "%20")+" >" + otherEvents.get(i) + "</a>"%>
							<%
								}
							%>
						</div>
					</div>

				</div>
			</nav>
			<div class="holder">
				<h1><%=eventName%></h1>
			</div>
		</div>

		<div class="participant">
			<section class="related-athletes">
				<header class="heading">
					<h2>Participants</h2>
					<ul class="add-links">
						<li><a href="Athletes.jsp">Go to more Athletes-></a></li>
					</ul>
				</header>
				<ul class="related-list col6">
					<%
						for (int i = 0; i < pictures.size(); i++) {
					%>
					<%="<li>" + "<div class='holder'>" + "<a href=IndividualDetailServlet?AthleteName="
						+ (java.net.URLEncoder.encode(pictures.get(i).getAthlete_name(), "UTF-8")).replace("+", "%20") + ">" + "<picture class='image'>" + "<img src="
						+ pictures.get(i).getA_Path() + " alt=" + pictures.get(i).getAthlete_name() + ">" + "</picture>"
						+ "</a>" + "<a href=IndividualDetailServlet?AthleteName=" + (java.net.URLEncoder.encode(pictures.get(i).getAthlete_name(), "UTF-8")).replace("+", "%20")
						+ ">" + "<strong class='name'>" + pictures.get(i).getAthlete_name() + "</strong>" + "</a>"
						+ "<a href=DelegationServlet?delegation=" + (java.net.URLEncoder.encode(pictures.get(i).getDelegation_name(), "UTF-8")).replace("+", "%20") + ">"
						+ "<div class='profile-row'>" + "<div class='flag-image'>" + "<img src="
						+ pictures.get(i).getPath() + " alt=" + pictures.get(i).getDelegation_name()
						+ " width='20px' height='13px'>" + "</div>" + "<span>" + pictures.get(i).getDelegation_name()
						+ "</span>" + "</div>" + "</a>" + "</li>"%>
					<%
						}
					%>
				</ul>
			</section>
		</div>


		<div class="result">
		<h4>Click the table head to sort</h4>
			<%
				for (int i = 0; i < getEventSchedule.size(); i++) {
			%>
			<%="<section class='table-box'>" + "<header class='heading'>"
						+ "<div style='float:left;'>" + "<text>" + getEventSchedule.get(i).getState() + "</text>" + "</div>"
						+ "<div style='margin-left:400px;'>" + "<text> Date:"
						+ getEventSchedule.get(i).getDate() + "</text>" + "</div>" + "</header>" + "<table class='table4'>"
						+ "<caption class='hide'>Table</caption>" + "<thead>" + "<tr class='th-row'>"
						+ "<th class='col1'>Rank</th>" + "<th class='col2'>Athlete</th>"
						+ "<th class='col3'>Delegation</th>" + "<th class='col4'>Grade</th>" + "</tr>" + "</thead>"
						+ "<tbody>"%>
			<%
				String state = getEventSchedule.get(i).getState();
			%>
			<%
				List<String> individualResult = eventNameDao.getIndiResult(eventName, state);
			%>
			<%
				for (int j = 0; j < individualResult.size(); j += 5) {
			%>
			<%="<tr>" + "<td class='col1'>" + "<div class='medal'>" + "<span>" + individualResult.get(j)
							+ "<span/>" + "</div>" + "</td>" +

							"<td class='col2'>" + "<div class='profile-section'>"
							+ "<a href=IndividualDetailServlet?AthleteName=" +(java.net.URLEncoder.encode(individualResult.get(j + 1), "UTF-8")).replace("+", "%20")  + ">"
							+ "<picture class='picture'>" + "<img src=" + individualResult.get(j + 3) + " alt='"
							+ individualResult.get(j + 1) + "'>" + "</picture>" + "<div class='text-box'>"
							+ "<strong class='name'>" + individualResult.get(j + 1) + "</strong>" + "</div>" + "</a>"
							+ "</div>" + "</td>" +

							"<td class='col3' style='padding-left:40px;'>" + "<a href=DelegationServlet?delegation=" + (java.net.URLEncoder.encode(individualResult.get(j + 2), "UTF-8")).replace("+", "%20")
							+ ">" + individualResult.get(j + 2) + "</a>" + "</td>" + "<td class='col4' style='padding-left:10px;'>"
							+ individualResult.get(j + 4) + "</td>" + "</tr>"%>
			<%
				}
			%>
			<%="</tbody>" + "</table>" + "</section>"%>
			<%
				}
			%>
		</div>

	</div>
	<!-- footer -->
	<div id="page-footer"></div>
</body>
<script type="text/javascript">
    $(".table4").tablesorter();
  </script>
</html>