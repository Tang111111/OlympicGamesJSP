<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page language="java" import="java.util.*,dao.*,bean.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/resultsecion.css" />
<link rel="stylesheet" type="text/css" href="css/administrator.css" />
<script src="js/jquery.js"></script>
<script src="js/bootstrap3.0.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

<script src="js/bootstrap-select.js"></script>
<link rel="stylesheet" type="text/css"
	href="css/bootstrap-select_2.0.0-beta1.css" />
<script>
function add() {
	$(".athleteInfo")
		.append(
			"<div style='display: flex;justify-content: center; width: 1000px' class='athleteDetail'>" +
			"<div style='margin: 20px;'>athleteName<input /></div>" +
			"<div style='margin: 20px;'>sex<input /></div>" +
			"<div style='margin: 20px;'>delegation<input /></div>" +
			"<div style='margin: 20px;'>birthday<input/></div>" +
			"</div>");
}

function remove() {
	$(".athleteDetail").empty();
}
</script>
<title>createCompetition</title>
</head>
<body>

	<div class="results-section">
		<div class="results-container">
			<h1>ADMINISTRATOR</h1>
			<br />

		</div>
	</div>
	<div class="out">
		<div class="button">
			<button id="insert" name="choose" type="button"
				onclick="showInsert()">INSERT</button>
		</div>
		<div class="button">
			<button id="update" name="choose" type="button"
				onclick="showUpdate()">UPDATE</button>
		</div>
		<div class="button">
			<button id="update" name="choose" type="button"
				onclick="showCreate()">CREATE</button>
		</div>
		<div class="button">
			<button onclick="window.location.href='index.jsp'">RETURN</button>
		</div>
	</div>
	<div class="holder"></div>
	<div id="createDiv">
			<div class="results-section">
				<div class="results-container">
					<div class="search-box">
						<form id="createCompetition" action="InsertCompetionServlet" method="get">
							<div class="form-group">
								<label for="sports-option" class="col-lg-2 control-label">sports</label>
								<div class="col-lg-10">
									<select id="sports-option" class="selectpicker show-tick form-control" name='Sports' data-live-search="true" onchange="selectOnchange(this)">
										<option data-hidden="true" value="0" disable>sports</option>
										<%
										SportsDao sportsDao = new SportsDao();
										List<String> allSportsName = sportsDao.getSportsNames();
									%>
										<%
										for (int i = 0; i < allSportsName.size(); i++) {
									%>
										<%="<option  value='" + allSportsName.get(i) + "'>" + allSportsName.get(i) + "</option>"%>
										<%
										}
									%>
									</select>
								</div>
								<div class="holder"></div>
								<div>
									event name: <br />
									<input type="text" name="Event" />
								</div>
								<div>
									type: <br />
									<input type="text" name="type" />
								</div>
								<div>
									priliminary event date:<br />
									<input type="text" name="priDate" />
								</div>
								<div>
									semifinal event date:<br />
									<input type="text" name="semiDate" />
								</div>
								<div>
									final event date:<br />
									<input type="text" name="finDate" />
								</div>
								<br /><br />
								<div class="button" style="float: right;">
									<button id="addAthlete" type="button" onclick="add()"> ADD</button>
								</div>

								<h3 style="float: left;">priliminary atttendance</h3>

								<br />
								<div class="athleteInfo">
									<div style="display: flex;justify-content: center; width: 1000px" class="athleteDetail">

										<div style="margin: 20px;">athleteName<input  name="athlete"/></div>
										<div style="margin: 20px;">sex<input  name="sex" /></div>
										<div style="margin: 20px;" >delegation<input name="delegation" /></div>
										<div style="margin: 20px;" >birthday<input name="birthday"/></div>
										
									</div>
									
								</div>

								<div class="button" style="margin: 0 auto;">
									<input class="submitButton" type="submit" value="SUBMIT" />
								</div>
						</form>
						</div>
					</div>
				</div>
			</div>
</body>
</html>