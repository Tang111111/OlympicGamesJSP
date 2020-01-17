<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page language="java" import="java.util.*,dao.*,bean.*"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/resultsecion.css" />
<script src="js/jquery.js"></script>
<script src="js/bootstrap3.0.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="css/administrator.css" />
<script src="js/bootstrap-select.js"></script>
<link rel="stylesheet" type="text/css"
	href="css/bootstrap-select_2.0.0-beta1.css" />
<script type="text/javascript">
	var operationType  = "unselected";
	function selectOnchange(obj) {
		
		var selectedsport = $("#sports-option").find("option:selected").text();
		$
				.ajax({
					dataType : "json", //数据类型为json格式
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					type : "GET",
					data : {
						"SportsName" : selectedsport
					},
					url : "SearchServlet",
					statusCode : {
						404 : function() {
							alert('page not found');
						}
					},
					success : function(data, textStatus) {

						$('#event-option').attr("disabled", false);
						$("#event-option").empty();
						$("#event-option")
								.append(
										"<option id=&quot;events&quot; data-hidden=&quot;true&quot; value=&quot;0&quot; disabled=&quot;disabled&quot;>events</option>");

						for (var j = 0; j < data.length; j++) {
							$("#event-option").append(
									"<option value='"+data[j].event_name+"'>"
											+ data[j].event_name + "</option>");
						}
						$("#event-option").selectpicker('refresh');
						//event name加载完了，下面加载current state
					},
					error : function() {
						alert('noData');
					}
				});
	}


	function eventSelected(obj) {
		//选择一个event 返回当前和下一个state
		var selectedEvent = $("#event-option").find("option:selected").text();
		$
				.ajax({
					dataType : "json",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					type : "GET",
					data : {
						"eventName" : selectedEvent
					//传过去的数据
					},
					url : "ResultServlet",
					statusCode : {
						404 : function() {
							alert('page not found');
						}
					},
					success : function(data, textStatus) {
						document.getElementById("previousStates").innerHTML="";
						$("#currentState").html(
								"current state: " + data.currentState);
						$("#nextState").empty();
						$("#nextState").html(
								"<h2>next state: <input name='state' readonly placeholder='"+data.nextState+"' value='"+data.nextState+"'/></h2>");
						
						var state = data.currentState;
						var previousStates = data.previousStates;
						var array = new Array("preliminary","semifinal","final");
						if(operationType == "insert"){
							//$("#previousStates").append("<div class='button'><input name='idradio' type='radio' value="+state+" />"+state+"</div>");
							
							getParticipants($("#event-option").find("option:selected").text(),state);
						}
						if(operationType == "update"){
							for(var mycounter = 0;mycounter<previousStates;mycounter++){
								$("#previousStates").append("<div class='button'><input name='idradio' type='radio' onclick='radioOnChange(this)' value="+array[mycounter]+" />"+array[mycounter]+"</div>");
							}
							
						}

					},
					error : function() {
						alert('Get current state failed.');
					}
				});
	}
	
	function radioOnChange(obj){
		var selected = obj.value;
		getParticipants($("#event-option").find("option:selected").text(),selected)
	}
	
	function getParticipants(eventName,state){
		//返回给定state的所有player的姓名 国家 按成绩排名(初赛开始之前 没成绩 不影响)
		$
				.ajax({
					dataType : "json", //数据类型为json格式
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					type : "GET",
					data : {
						"eventName" : eventName,//传过去的数据
						"state" : state
					},
					url : "GetPlayerServlet",
					statusCode : {
						404 : function() {
							alert('page not found');
						}
					},
					success : function(data, textStatus) {//往表格加载运动员/国家数据
						var number = data.length;//运动员个数
	
						$(".infoTable tr:not(:first)").remove();//清空除了第一行之外的数据
						for (var counter = 0; counter < number; counter++) {
							if (state == "final") {
								$(".infoTable").hide();
								$(".submitButton").hide();
							} else {
								$(".infoTable").show();
								$(".submitButton").show();
								$(".infoTable")
										.append(
												"<tr style='height: 150px;'><td class='athlete'><input name='athlete' value='"+data[counter].name+"' readonly placeholder="+data[counter].name.replace(rex,"&nbsp;")+" />"
												+ "</td><td class='delegation'><input name='delegation' value='"+data[counter].delegation+"' readonly placeholder="+data[counter].delegation+" />"
												+ "</td><td ><input type='text' class='grade' name='grade'  /> </td>"
												+ "<td ><input type='text' name='rank' /> </td></tr>"

										);
							}
						}

					},
					error : function() {
						alert('Get current state failed.');
					}
				});
	}
</script>
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

</script>
<title>Administration Page</title>
</head>

<body style="font-family:" microsoft sansserif ";">
	<div class="results-section">
		<div class="results-container">
			<h1>ADMINISTRATOR</h1>
			<br />
			
		</div>

	</div>
	<div class="out">
		<div class="button">
			<button id="insert" name="choose" type="button"
				onclick="document.getElementById('insertDiv').style.display = 'block';operationType='insert';document.getElementById('previousStates').innerHTML=''">
				Add Results</button>
		</div>
		<div class="button">
			<button id="update" name="choose" type="button"
				onclick="document.getElementById('insertDiv').style.display = 'block';operationType='update';document.getElementById('previousStates').innerHTML=''">
				Update Results</button>
		</div>
		<div class="button">
			<button onclick="window.location.href='index.jsp'">Return</button>
		</div>
		<div class="button">
			<button onclick="document.getElementById('insertDiv').style.display = 'none';document.getElementById('createDiv').style.display = 'block';operationType='create';document.getElementById('previousStates').innerHTML=''">
				Create Competitions</button>
		</div>
	</div>
	<div class="holder"
		style="clear: both; height: 1px; width: 100%; overflow: hidden; margin-top: -1px;"></div>
	<div id="insertDiv" class="newDiv">
		<!-- resluts section-->
		<div class="results-section">
			<div class="results-container">
				<div class="search-box">
					<form class="form-horizontal" role="form" action="InsertServlet" method="get">
					<h2 id="currentState"  value="current">current
				state:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h2>
						<div class="form-group">
							<label for="sports-option" class="col-lg-2 control-label">sports</label>
							<div class="col-lg-10">
								<select id="sports-option"
									class="selectpicker show-tick form-control" name='Sports' 
									data-live-search="true" onchange="selectOnchange(this)">
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
							<label for="event-option" class="col-lg-2 control-label">Event</label>
							<div class="col-lg-10">
								<select id="event-option"
									class="selectpicker show-tick form-control"
									data-live-search="true" disabled="disabled" name='Event' 
									onchange="eventSelected(this)">
									<option id="events" data-hidden="true" value="0"
										disabled="disabled">events</option>
								</select>
							</div>
							<div class="holder"
								style="clear: both; height: 1px; width: 100%; overflow: hidden; margin-top: -1px;"></div>

							<div class="out" id="previousStates"></div>
							<div class="out" id="nextState"></div>
							<table class="infoTable" id="infoTable" border="0" cellspacing="0"
								cellpadding="0" rules="rows" style="width: 100%;">
								<tr id="tableHead" style="height: 30px;">
									<th style="text-align: center;">ATHLETE</th>
									<th style="text-align: center;">DELEGATION</th>
									<th style="text-align: center;">GRADE</th>
									<th style="text-align: center;">RANK</th>
								</tr>


							</table>
						</div>
						<div class="button"  style="margin: 0 auto;">
							<input class="submitButton" type="submit" value="SUBMIT" />
						</div>

					</form>
				</div>

			</div>

		</div>
		<!-- //resluts section-->
	</div>
	
	
	<div id="createDiv" style="display:none">
			<div class="results-section">
				<div class="results-container">
					<div class="search-box">
						<form id="createCompetition" action="InsertCompetionServlet" method="get">
							<div class="form-group">
								<label for="sports-option" class="col-lg-2 control-label">sports</label>
								<div class="col-lg-10">
									<select id="sports-option" class="selectpicker show-tick form-control" name='Sports' data-live-search="true" onchange="selectOnchange(this)">
										<option data-hidden="true" value="sportname" disable>sports</option>
										<%
										allSportsName = sportsDao.getSportsNames();
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
								<label for="event-types-option" class="col-lg-2 control-label">type</label>
								<div class="col-lg-10">
									<select id="event-types-option" class="selectpicker show-tick form-control" name='Event' data-live-search="true">
										<option data-hidden="true" value="type" disable>type</option>
										<option value="1">individual</option>
										<option value="2">team</option>
									</select>
								</div>
								<div class="holder"></div>
								<div style="text-align:left">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;event name: &nbsp;&nbsp;&nbsp;&nbsp;
									<input type="text" name="Event" />
								</div>
								<div class="holder"></div>
								<div style="text-align:left">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;preliminary event date: (YYYY-MM-DD)&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="text" name="priDate" />
								</div>
								
								<div class="holder"></div>
								<div style="text-align:left">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;semifinal event date: (YYYY-MM-DD)&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="text" name="semiDate" />
								</div>
								
								<div class="holder"></div>
								<div style="text-align:left">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;final event date:  (YYYY-MM-DD)&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="text" name="finDate" />
								</div>
								<br /><br />
								<div class="button" style="float: right;">
									<button id="addAthlete" type="button" onclick="add()"> ADD</button>
								</div>

								<h3 style="float: left;">preliminary attendance</h3>

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