<%@page language="java" import="java.util.*,dao.*,bean.*"  %>
<!DOCTYPE html>
<html>

<head>
	<title>Swimming</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="css/Head.css" />
	<link rel="stylesheet" type="text/css" href="css/headPicture.css" />
	<link rel="stylesheet" type="text/css" href="css/gallary.css"/>
	<style type="text/css">
		.chooseGame li {
			margin: 10px;
			list-style: none;
			margin-left: 30px;
			font-family: "microsoft yahei";
		}

		.chooseGame #state {
			float: right;
		}
	</style>
	<script src="js/jquery.js"></script>
	<script type="text/javascript">
        $(document).ready(function () {
            $('#page-head').load('header.jsp');
            $('#page-footer').load('footer.jsp');
        });
	</script>
	
	<% String sportName=request.getParameter("Sports");%>
	<% SportsDao sportsDao = new SportsDao(); %>
	<% PictureDao picDao = new PictureDao(); %>
	<% List<Event> team_event_list =  sportsDao.getTeamEvent(sportName); %> <!-- 得到两个游泳团体项目和状态 -->
	<% List<Event> indi_event_list = sportsDao.getIndividualEvent(sportName); %> <!-- 得到两个游泳个人项目和状态 -->
	<% String coverpic = picDao.getSportsCover(sportName); %><!-- cover picture -->
	<% List<String> gallery_pics = picDao.getSportsGallery(sportName); %><!-- 游泳项目的gallery图片 -->
</head>

<body>
<!-- header -->
<div id="page-head"></div>

<div class="headPicture">
	<img src=<%=coverpic%> width="100%" /><% System.out.println(coverpic); %>
	<h2><%=sportName %></h2>
</div>
<br />
<div style="width: 1000px;margin:0 auto;">
	<div class="chooseGame" style="width: auto;">
		<div class="team">
			<h2>Team Competition</h2>
			<hr />
			<div>
			<% for(int i=0;i<team_event_list.size();i++){ %>
			<%="<li>"+
					"<div>"+
						"<text>"+
							"<a href='TeamServlet?Sports="+sportName+ "&Event="+ team_event_list.get(i).getEvent_name()+"'>"+
								team_event_list.get(i).getEvent_name()+
							"</a>"+ 
						"</text>"+
						"<div id='state'>"+team_event_list.get(i).getState()+"</div>"+
					"</div>"+
				"</li>" %>
			<% }%>
			</div>

		</div>
		<div class="individual">
			<h2>Individual Competition</h2>
			<hr />
			<div>
				<% for(int i=0;i<team_event_list.size();i++){ %>
				<%="<li>"+
						"<div>"+
							"<text>"+
								"<a href='IndividualServlet?Sports="+sportName+ "&&Event="+ indi_event_list.get(i).getEvent_name()+"'>"+
									indi_event_list.get(i).getEvent_name()+
								"</a>"+ 
							"</text>"+
							"<div id='state'>"+indi_event_list.get(i).getState()+"</div>"+
						"</div>"+
					"</li>" %>
				<% }%>
			</div>
		</div>
	</div>
	<br />
	<br />
	<div style="width: auto;">
		<div>
			<h2>GALLARY</h2>
			<hr />
		</div>
		<div id="gallary" >
			<% for(int i=0;i<gallery_pics.size();i++){ %>
			<%="<img src="+gallery_pics.get(i)+" />"%>
			<% } %>
		</div>
	</div>
</div>



<!-- footer -->
<div id="page-footer"></div>

</body>

</html>