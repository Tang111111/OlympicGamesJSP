<%@page language="java" import="java.util.*,dao.*,bean.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Olympic Games-Results</title>
<script src="js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<script src="js/bootstrap-select.js"></script>
<link rel="stylesheet" type="text/css"
	href="css/bootstrap-select_2.0.0-beta1.css" />

<link rel="stylesheet" type="text/css" href="css/resultsecion.css" />
<script type="text/javascript">
	$(document).ready(function() {
		$('#page-head').load('header.jsp');
		$('#page-footer').load('footer.jsp');
	});
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

					},
					error : function() {
						alert('noData');
					}
				});
	}
</script>



</head>
<body>
	<!-- header -->
	<div id="page-head"></div>

	<!-- resluts section-->
	<div class="results-section">
		<div class="results-container">
			<h1 style="margin: 0px; padding-top: 10px;">RESULTS</h1>
			<div class="search-box">
				<form class="form-horizontal" action="JumpServlet" role="form" name="fname">
					<div class="form-group">
						<label for="sports-option" class="col-lg-2 control-label">sports</label>
						<div class="col-lg-10">
							<select id="sports-option" name="Sports"
								class="selectpicker show-tick form-control"
								data-live-search="true" onchange="selectOnchange(this)">
								<option data-hidden="true" value="0" disable>sports</option>
								<%
									SportsDao sportsDao = new SportsDao();
									List<String> allSportsName = sportsDao.getSportsNames();
								%>
								<%
									for (int i = 0; i < allSportsName.size(); i++) {
								%>
								<%="<option value='" + allSportsName.get(i) + "'>" + allSportsName.get(i) + "</option>"%>
								<%
									}
								%>
								
							</select>
							</select>
						</div>
						<label for="event-option" class="col-lg-2 control-label">Event</label>
						<div class="col-lg-10">
							<select id="event-option" name="Event"
								class="selectpicker show-tick form-control"
								data-live-search="true" disabled="disabled">
								<option id="events" data-hidden="true" value="0"
									disabled="disabled">events</option>
							</select>
						</div>

						<div class="holder"></div>

						<div class="">
							<input type="submit" id="seach"
								style="color: white; background-color: #5CB85C; border: none; width: 100px; height: 30px;"
								value="Search"></input>
						</div>
					</div>
					<form>
			</div>
		</div>
	</div>
	<!-- //resluts section-->


	<div class="holder"></div>
	<div class="holder"></div>
	<!-- footer -->
	<div id="page-footer"></div>
</body>


</html>
