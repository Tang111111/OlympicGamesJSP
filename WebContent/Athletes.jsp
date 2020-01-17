<%@page language="java" import="java.util.*,dao.*,bean.*"   %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>SPORTS</title>
	<link rel="stylesheet" type="text/css" href="css/Head.css"/>
	<link rel="stylesheet" type="text/css" href="css/listStyle.css"/>
	<link rel="stylesheet" type="text/css" href="css/header.css" />
	<script src="js/jquery.js"></script>
	<script type="text/javascript">
        $(document).ready(function () {
            $('#page-head').load('header.jsp');
            $('#page-footer').load('footer.jsp');
        });
	</script>
</head>
<%! PictureDao athleteDao=new PictureDao(); %> 
<%  List<Picture> athleteLogo=athleteDao.getAllAthlete(); %>
<body>
<!-- header -->
<div id="page-head"></div>

<div class="head" style="background-color: firebrick;">
	<h1>Athletes</h1>
</div>
<br />
<br />
<div style="width: 80%;margin: 0 auto; height: 1000px;">
	<div style="width:auto;"align="middle">
		<div class='select' align="middle">
			<% for(int i=0;i<athleteLogo.size();i++){%>
		<%="<li>"+
				"<a href=IndividualDetailServlet?AthleteName="+(java.net.URLEncoder.encode(athleteLogo.get(i).getAthlete_name(), "UTF-8")).replace("+", "%20")+">"+
				"<div id='spots_icon'>"+
					"<img src="+athleteLogo.get(i).getA_Path()+" width='100' height='80'>"+
				"</div >"+
				"<div id="+athleteLogo.get(i).getAthlete_name()+">"+
						athleteLogo.get(i).getAthlete_name()+
				"</div>"+			
			"</a>"+
		"</li>" %>
		<% } %>
		</div>
	</div>

</div>
<!-- footer -->
<div id="page-footer"></div>
</body>

</html>