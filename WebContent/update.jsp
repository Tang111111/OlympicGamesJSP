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
						$("#currentState").html(
								"current state: " + data.currentState);
						var state = data.currentState;

						//返回给定state的所有player的姓名 国家 按成绩排名(初赛开始之前 没成绩 不影响)
						$
								.ajax({
									dataType : "json", //数据类型为json格式
									contentType : "application/x-www-form-urlencoded; charset=utf-8",
									type : "GET",
									data : {
										"eventName" : selectedEvent,//传过去的数据
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
																"<tr style='height: 150px;' name='rank'><td >"
																		+ (counter + 1)
																		+ "</td><td name='athlete'><div>"
																		+ data[counter].name
																		+ "</div></td><td name='delegation'>"
																		+ data[counter].delegation
																		+ "</td><td ><input type='text' name='grade' /> </td></tr>"

														);
											}
										}

									},
									error : function() {
										alert('Get current state failed.');
									}
								});

					},
					error : function() {
						alert('Get current state failed.');
					}
				});
		function submitButton() {
			alert(alsjdkfj);
			$
					.ajax({
						dataType : "json", //数据类型为json格式
						contentType : "application/x-www-form-urlencoded; charset=utf-8",
						type : "GET",
						data : {
							"Sports" : selectedsport,
							"Event" : selectedEvent,
							"state" : state
						},
						url : "InsertServlet",
						statusCode : {
							404 : function() {
								alert('page not found');
							}
						},
						success : function(data, textStatus) {
							alert(data);
						},
						error : function() {
							alert('noData');
						}
					});
		}

		

	}
</script>

<title>JSP Page</title>
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
				onclick="document.getElementById('insertDiv').style.display = 'block';document.getElementById('updateDiv').style.display = 'none';">
				INSERT</button>
		</div>
		<div class="button">
			<button id="update" name="choose" type="button"
				onclick="document.getElementById('updateDiv').style.display = 'block';document.getElementById('insertDiv').style.display = 'none';">
				UPDATE</button>
		</div>
		<div class="button">
			<button onclick="window.location.href='index.jsp'">RETURN</button>
		</div>
	</div>
	<div class="holder"
		style="clear: both; height: 1px; width: 100%; overflow: hidden; margin-top: -1px;"></div>
	<div id="updateDiv" class="newDiv">
		<!-- resluts section-->
		<div class="results-section">
			<div class="results-container">
				<div class="search-box">
					<form class="form-horizontal" role="form">
					<h2 id="currentState" name="state" value="current">current
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

							<div id="stateDiv" style="">
									<strong>state</strong>
									<div class="out">
										<div class="button">
											<input name="idradio" type="radio" value="PRILIMINARY" />PRILIMINARY
										</div>
										<div class="button">
											<input name="idradio" type="radio" value="SEMIFINAL" />SEMIFINAL
										</div>
										<div class="button">
											<input name="idradio" type="radio" value="FINAL" />FINAL
										</div>
									</div>
								</div>
							<table class="infoTable" border="0" cellspacing="0"
								cellpadding="0" rules="rows" style="width: 100%;">
								<tr id="tableHead" style="height: 30px;">
									<th style="text-align: center;">RANK</th>
									<th style="text-align: center;">ATHLETE</th>
									<th style="text-align: center;">DELEGATION</th>
									<th style="text-align: center;">GRADE</th>
								</tr>


							</table>
						</div>
						<div class="button" style="margin: 0 auto;">
							<button class="submitButton" type="button" value="SUBMIT" click="submitButton()"  >SUBMIT</button>
						</div>

					</form>
				</div>

			</div>

		</div>
		<!-- //resluts section-->
	</div>




</body>

</html>