<%@page language="java" import="java.util.*,dao.*,bean.*"  %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>SPORTS</title>
	<link rel="stylesheet" type="text/css" href="css/Head.css"/>
	<link rel="stylesheet" type="text/css" href="css/listStyle.css"/>
	<script src="js/jquery.js"></script>
	<script type="text/javascript">
        $(document).ready(function () {
            $('#page-head').load('header.jsp');
            $('#page-footer').load('footer.jsp');
        });
	</script>
</head>
<%!PictureDao sportsDao=new PictureDao(); %>
<% List<Picture> sportsLogo=sportsDao.getAllSportslogo();
for(int i=0;i<sportsLogo.size();i++){
	System.out.println(sportsLogo.get(i).getPath());
}
%>
<body>
<!-- header -->
<div id="page-head"></div>

<div class="head" style="background-color: firebrick;">
	<h1>SPORTS</h1>
</div>
<br />
<br />
<div style="width: 80%;margin: 0 auto;">
	<div style="width:auto;" align="middle">
		<div class='select' align="middle">
			<% for(int i=0;i<sportsLogo.size();i++){%>
		<%="<li>"+
				"<a href=SportsServlet?Sports="+sportsLogo.get(i).getSports_name()+">"+
				"<div id='spots_icon'>"+
					"<img src="+sportsLogo.get(i).getPath()+" width='100' height='80'>"+
				"</div >"+
				"<div id="+sportsLogo.get(i).getSports_name()+">"+
						sportsLogo.get(i).getSports_name()+
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